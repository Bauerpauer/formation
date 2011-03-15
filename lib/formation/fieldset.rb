class Formation::Fieldset
  
  attr_reader :name, :legend
  
  def initialize(name, options = {})
    @name = name
    @legend = options[:legend] || Formation::Util.titleize(name)
  end
  
  def fields
    @fields ||= []
  end
  
end