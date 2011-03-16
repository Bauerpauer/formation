class Formation::Field < Formation::Element
  
  attr_reader :label, :fieldset, :type
  attr_accessor :value
  
  def initialize(name, options = {})
    @name = name
    if @fieldset = options.delete(:fieldset)
      @fieldset.fields << self
    end
    @type = options.delete(:type) || :text
    @type = Formation::Type.create(self, @type)
    @label = options.delete(:label) || Formation::Util.titleize(@name)
    @required = options.delete(:required) || false
    
    # Attach any left-over entries as accessors
    options.each do |key, value|
      metaclass = class << self; self; end
      metaclass.send :attr_accessor, key.to_sym
      send "#{key}=", value
    end
  end
  
  def field?
    true
  end
  
  def required?
    @required
  end
  
end