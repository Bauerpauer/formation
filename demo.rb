require 'rubygems'
require 'sinatra'
require 'datamapper'
require File.expand_path('../lib/formation', __FILE__)

class Post
  
  include DataMapper::Resource
  
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
  
end

class PostForm
  
  include Formation::Form
  
  resource :post
  
  field 'post[title]', :label => 'Title', :required => true
  field 'post[body]', :label => 'Body', :required => true
  
  def initialize(post)
    @post = post
  end
  
end

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

DataMapper.setup :default, 'sqlite::memory:'
DataMapper.auto_migrate!

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

get '/posts/new' do
  @form = PostForm.new(Post.new)
  erb :new_post
end

post '/posts' do
  @form = PostForm.new(Post.new)
  @form.submit params
  if @form.valid?
    @form.post.save
    redirect "/posts/#{@form.post.id}"
  else
    erb :new_post
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

@@ new_post
<h1>New Post</h1>
<form action="/posts" method="post">
  <% @form.errors.each do |error| %>
    <p style="color: red"><%= error %></p>
  <% end %>
  <% @form.elements.each do |element| %>
    <% if element.is_a? Formation::Field %>
      <label><%= element.label %></label>
      <input type="text" name="<%= element.name %>" value="<%= @form.values[element.name] %>" />
    <% end %>
  <% end %>
  <input type="submit" />
</form>