require File.expand_path('../test_helper', __FILE__)

describe Formation::Form do
  
  describe '#fields' do
    
    it 'should have the correct name' do
      SimpleForm.fields['first_name'].name.must_equal 'first_name'
    end
    
    it 'should have the label of the fieldset it belongs to (if any)' do
      SimpleForm.fields['address'].fieldset.legend.must_equal 'Address'
    end
    
    it 'should pass-through custom attributes' do
      SimpleForm.fields['username'].custom.must_equal 'test'
    end
    
  end
  
  describe '#fieldsets' do
    
    it 'should contain the fields belonging to it' do
      SimpleForm.fieldsets['Address'].fields.map(&:name).must_equal %w{ address city }    
    end
  
  end
  
  describe 'an instance' do
    
    before do
      @simple_form = SimpleForm.new(:first_name => 'Chris')
      @post = OpenStruct.new(:title => 'Test')
      @model_form = PostForm.new(@post)
    end
    
    describe '.elements' do
      
      it 'should return the elements in the correct order' do
        @simple_form.elements.map(&:name).must_equal %w{ first_name Address login_details }
      end
      
    end
  
    describe '.submit' do
    
      it 'should accept empty params' do
        @simple_form.submit({})
      end
      
      it 'should extract values of fields' do
        @simple_form.submit({'first_name' => 'Christopher' })
        @simple_form.values['first_name'].must_equal 'Christopher'
        
        @model_form.submit({'post' => { 'title' => 'Testing' }, 'author' => { 'name' => 'Chris'}})
        @model_form.post.title.must_equal 'Testing'
      end
      
      it 'should be valid if all required values were provided' do
        @simple_form.submit({'first_name' => 'Christopher' })
        @simple_form.valid?.must_equal true
      end
      
      it 'should not be valid if all required values were not provided' do
        @simple_form.submit({})
        @simple_form.valid?.must_equal false
      end
    
      it 'should have an error for each missing required value' do
        @simple_form.submit({})
        @simple_form.errors.must_equal ['First Name is required']
      end
    
    end
    
    describe '.values' do
      
      it 'should extract values from resource' do
        @simple_form.values['first_name'].must_equal 'Chris'
      end
      
    end
    
  end
  
end