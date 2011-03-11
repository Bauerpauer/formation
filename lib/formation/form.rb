module Formation::Form
  
  module ClassMethods
    
    def elements
      @elements ||= []
    end
    
    def field(name, options = {})
      @_current_fieldset ||= nil
      name = name.to_s
      fields[name] = Formation::Field.new(name, { :fieldset => @_current_fieldset }.merge(options))
      elements << fields[name] unless @_current_fieldset
    end
  
    def fields
      @fields ||= {}
    end
    
    def fieldset(legend)
      @_current_fieldset = (fieldsets[legend] ||= Formation::Fieldset.new(legend))
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
    end
    
    def resources
      @resources ||= []
    end
    
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def elements
    # TODO: Return elements but w/ values
    self.class.elements
  end
  
  def errors
    @errors ||= []
  end
  
  def submit(params)
    errors.clear
    self.class.fields.each do |name, field|
      value = extract_value_from_params(name, params)
      if field.required? && (value.nil? || value.empty?)
        errors << "#{name} is required"
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