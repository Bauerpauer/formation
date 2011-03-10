class Formation::Fieldset
  
  attr_reader :name, :legend
  
  def initialize(name, options = {})
    @name = name
    @legend = options[:legend] || name
  end
  
  def fields
    @fields ||= []
  end
  
end