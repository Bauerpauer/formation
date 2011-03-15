class Formation::Util
  
  def self.titleize(string)
    string.to_s.gsub(/_/, ' ').gsub(/\b\w/) { $&.upcase }
  end
  
  def self.underscore(string)
    string.to_s.downcase.gsub(/\s/, '_')
  end
  
end