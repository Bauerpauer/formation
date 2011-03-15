class Formation::Field < Formation::Element
  
  attr_reader :label, :fieldset
  attr_accessor :value
  
  def initialize(name, options = {})
    @name = name
    if @fieldset = options[:fieldset]
      @fieldset.fields << self
    end
    @label = options[:label] || Formation::Util.titleize(@name)
    @required = options[:required] || false
  end
  
  def field?
    true
  end
  
  def required?
    @required
  end
  
end