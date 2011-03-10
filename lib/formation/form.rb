module Formation::Form
  
  module ClassMethods
    
    def elements
      @elements ||= []
    end
    
    def field(name, options = {})
      @_current_fieldset ||= nil
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
      values[name] = extract_value_from_params(name, params)
      if field.required? && (values[name].nil? || values[name].empty?)
        errors << "#{name} is required"
      end
    end
    valid?
  end
  
  def valid?
    !errors.any?
  end
  
  def values
    @values ||= Hash.new
  end
  
  private
  
  def extract_value_from_params(name, params)
    return params[name] if params[name]
    key = %r{([^\[\]=&]+)}.match(name).captures.first
    if params.has_key?(key)
      branch = params[key].dup
      %r{\[([^\[\]=&]+)\]}.match(name).captures.each do |capture|
        branch = branch[capture]
      end
      branch
    end
  end
  
end