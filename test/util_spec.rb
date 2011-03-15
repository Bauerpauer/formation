require File.expand_path('../test_helper', __FILE__)

describe Formation::Util do
  
  describe '.titleize' do
    
    it 'should handle underscores and case' do
      Formation::Util.titleize('first_name').must_equal 'First Name'
    end
    
  end
  
  describe '.underscore' do
    
    it 'should handle spaces and case' do
      Formation::Util.underscore('First Name').must_equal 'first_name'
    end
    
  end
  
end