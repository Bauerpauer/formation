require File.expand_path('../../test_helper', __FILE__)

describe Formation::Types::TextArea do
  
  before do
    @field = Formation::Field.new('body', :type => :textarea)
    @type = @field.type
  end
  
  describe '.to_html' do
    
    describe 'with no value' do
      
      before do
        @field.value = nil
      end
    
      it 'should render correctly' do
        @type.to_html.must_equal <<-HTML.strip
          <textarea name="body"></textarea>
        HTML
      end
      
    end
    
    describe 'with a value' do
      
      before do
        @field.value = 'Blah, blah, blah'
      end
      
      it 'should render correctly' do
        @type.to_html.must_equal <<-HTML.strip
          <textarea name="body">Blah, blah, blah</textarea>
        HTML
      end
      
    end
    
  end
  
end