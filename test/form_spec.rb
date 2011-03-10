require File.expand_path('../test_helper', __FILE__)

class ::TestForm
  include Formation::Form
  
  field 'user[first_name]', :required => true
  
  fieldset 'Address' do
    field 'user[address]'
    field 'user[city]'
  end
  
  def initialize(user)
    @user = user
    values['user[first_name]'] = user.first_name
  end
end

describe Formation::Form do
  
  describe '#fields' do
    
    it 'should have the correct name' do
      TestForm.fields['user[first_name]'].name.must_equal 'user[first_name]'
    end
    
    it 'should have the label of the fieldset it belongs to (if any)' do
      TestForm.fields['user[address]'].fieldset.legend.must_equal 'Address'
    end
    
  end
  
  describe '#fieldsets' do
    
    it 'should contain the fields belonging to it' do
      TestForm.fieldsets['Address'].fields.map(&:name).must_equal %w{ user[address] user[city] }    
    end
  
  end
  
  describe 'an instance' do
    
    before do
      @user = OpenStruct.new(:first_name => 'Chris')
      @form = TestForm.new(@user)
    end
    
    describe '.elements' do
      
      it 'should return the elements in the correct order' do
        @form.elements.map(&:name).must_equal %w{ user[first_name] Address }
      end
      
    end
  
    describe '.submit' do
    
      it 'should accept empty params' do
        @form.submit({})
      end
      
      it 'should extract values of fields' do
        @form.submit({'user' => { 'first_name' => 'Christopher' } })
        @form.values['user[first_name]'].must_equal 'Christopher'
      end
      
      it 'should be valid if all required values were provided' do
        @form.submit({'user' => { 'first_name' => 'Christopher' } })
        @form.valid?.must_equal true
      end
      
      it 'should not be valid if all required values were not provided' do
        @form.submit({})
        @form.valid?.must_equal false
      end
    
      it 'should have an error for each missing required value' do
        @form.submit({})
        @form.errors.must_equal ['user[first_name] is required']
      end
    
    end
    
    describe '.values' do
      
      it 'should extract values from resource' do
        @form.values['user[first_name]'].must_equal 'Chris'
      end
      
    end
    
  end
  
end