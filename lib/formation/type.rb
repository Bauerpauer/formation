class Formation::Type
  
  def self.create(field, type)
    case type
    when :text
      Formation::Types::Text.new(field)
    when :textarea
      Formation::Types::TextArea.new(field)
    end
  end
  
end