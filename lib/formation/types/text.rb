class Formation::Types::Text
  
  attr_reader :field
  
  def initialize(field)
    @field = field
  end
  
  def to_html
    <<-HTML.strip
      <input type="text" name="#{field.name}" value="#{field.value}" />
    HTML
  end
  
end