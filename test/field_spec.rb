require File.expand_path('../test_helper', __FILE__)

describe Formation::Field do
  
  describe '.label' do
    
    it 'should use the given label, if specified' do
      Formation::Field.new('user[first_name]', :label => 'First Name').label.must_equal 'First Name'
    end
    
    it 'should use the name, if not specified' do
      Formation::Field.new('user[first_name]').label.must_equal 'user[first_name]'
    end
    
  end
  
end