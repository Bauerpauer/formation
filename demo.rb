require 'rubygems'
require 'sinatra'
require File.expand_path('../lib/formation', __FILE__)

class RegistrationForm
  
  include Formation::Form
  
  fieldset :account do
    field :login_name, :required => true
    field :password, :required => true
  end
  
  fieldset :address do
    field :address
    field :city
  end
  
end

get '/register' do
  @form = RegistrationForm.new
  erb :register
end

post '/register' do
  @form = RegistrationForm.new
  @form.submit params
  if @form.valid?
    erb :thanks
  else
    erb :register
  end
end

__END__

@@ layout
<html>
  <head></head>
  <body>
    <%= yield %>
  </body>
</html>

@@ register
<h1>Register</h1>
<form action="/register" method="post">
  <% @form.errors.each do |error| %>
    <p style="color: red"><%= error %></p>
  <% end %>
  <% @form.elements.each do |element| %>
    <% if element.is_a? Formation::Fieldset %>
      <fieldset>
        <legend><%= element.legend %></legend>
        <% element.fields.each do |field| %>
          <label><%= field.label %></label>
          <input type="text" name="<%= field.name %>" value="<%= @form.values[field.name] %>" />
          <br />
        <% end %>
      </fieldset>
    <% end %>
  <% end %>
  <input type="submit" />
</form>

@@ thanks
<h1>Thanks!</h1>