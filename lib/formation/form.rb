module Formation::Form
  
  module ClassMethods
    
    def elements
      @elements ||= []
    end
    
    def field(name, options = {})
      @_current_resource ||= nil
      @_current_fieldset ||= nil
      if @_current_resource
        name = "#{@_current_resource}[#{name}]"
      else
        name = name.to_s
      end
      fields[name] = Formation::Field.new(name, { :fieldset => @_current_fieldset }.merge(options))
      elements << fields[name] unless @_current_fieldset
    end
  
    def fields
      @fields ||= {}
    end
    
    def fieldset(name, options = {})
      if name.is_a? Hash
        options = name
        name = Formation::Util.underscore(options[:legend])
      end
      @_current_fieldset = (fieldsets[name] ||= Formation::Fieldset.new(name, options))
      elements << @_current_fieldset
      yield
      @_current_fieldset = nil
    end
    
    def fieldsets
      @fieldsets ||= {}
    end
    
    def resource(resource)
      resources << resource
      class_eval <<-RUBY
        attr_accessor :#{resource}
      RUBY
      if block_given?
        @_current_resource = resource
        yield
        @_current_resource = nil
      end
    end
    
    def resources
      @resources ||= []
    end
    
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def elements
    self.class.elements
  end
  
  def errors
    @errors ||= []
  end
  
  def fields
    fields = elements.map do |element|
      case element
      when Formation::Fieldset
        element.fields
      when Formation::Field
        element
      end
    end
    fields.flatten
  end
  
  def submit(params)
    errors.clear
    fields.each do |field|
      field.value = extract_value_from_params(field.name, params)
      if field.required? && (field.value.nil? || field.value.empty?)
        errors << "#{field.label} is required"
      end
    end
    valid?
  end
  
  def valid?
    !errors.any?
  end
  
  def values
    @values ||= {}
  end
  
  private
  
  def extract_value_from_params(name, params)
    key = %r{([^\[\]=&]+)}.match(name).captures.first
    value = if self.class.resources.include? key.to_sym
      captures = %r{\[([^\[\]=&]+)\]}.match(name).captures
      send(key).send("#{captures.first}=", params.send('fetch', key).send('fetch', captures.first))
    else
      if params[key]
        branch = params[key].dup
        match = %r{\[([^\[\]=&]+)\]}.match(name)
        if match
          match.captures.each do |capture|
            branch = branch[capture]
          end
        end
        branch
      else
        nil
      end
    end
    values[name] = value
  end
  
end