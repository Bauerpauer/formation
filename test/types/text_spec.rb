require File.expand_path('../../test_helper', __FILE__)

describe Formation::Types::Text do
  
  before do
    @field = Formation::Field.new('username', :type => :text)
    @type = @field.type
  end
  
  describe '.to_html' do
    
    describe 'with no value' do
      
      before do
        @field.value = nil
      end
    
      it 'should render correctly' do
        @type.to_html.must_equal <<-HTML.strip
          <input type="text" name="username" value="" />
        HTML
      end
      
    end
    
    describe 'with a value' do
      
      before do
        @field.value = 'chris'
      end
      
      it 'should render correctly' do
        @type.to_html.must_equal <<-HTML.strip
          <input type="text" name="username" value="chris" />
        HTML
      end
      
    end
    
  end
  
end