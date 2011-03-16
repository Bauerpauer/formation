class SimpleForm
  include Formation::Form
  
  field 'first_name', :required => true
  
  fieldset 'Address' do
    field 'address', :type => :text
    field 'city', :type => :text
  end
  
  fieldset :legend => 'Login Details' do
    field 'username', :custom => 'test'
  end
  
  def initialize(options = {})
    options.each do |key, value|
      values[key.to_s] = value
    end
  end
  
end