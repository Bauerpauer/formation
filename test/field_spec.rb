require File.expand_path('../test_helper', __FILE__)

describe Formation::Field do
  
  describe '.label' do
    
    it 'should use the given label, if specified' do
      Formation::Field.new('first_name', :label => 'Name').label.must_equal 'Name'
    end
    
    it 'should use the titleized name, if not specified' do
      Formation::Field.new('first_name').label.must_equal 'First Name'
    end
    
  end
  
end