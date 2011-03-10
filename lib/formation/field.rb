class Formation::Field
  
  attr_reader :name, :label, :value
  attr_reader :fieldset
  
  def initialize(name, options = {})
    @name = name
    if @fieldset = options[:fieldset]
      @fieldset.fields << self
    end
    @label = options[:label] || @name
    @required = options[:required] || false
  end
  
  def required?
    @required
  end
  
end