class Formation::Types::TextArea
  
  attr_reader :field
  
  def initialize(field)
    @field = field
  end
  
  def to_html
    <<-HTML.strip
      <textarea name="#{field.name}">#{field.value}</textarea>
    HTML
  end
  
end