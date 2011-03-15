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
  
  resource :post do
    fieldset :legend => 'New Post' do
      field :title, :label => 'Title', :required => true
      field :body, :label => 'Body', :required => true
    end
  end
  
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

get '/styles.css' do
  <<-CSS
    *, html {
      font-family: Verdana, Arial, Helvetica, sans-serif;
    }
    body, form, ul, li, p, h2, h3, h4, h5 {
      margin: 0;
      padding: 0;
    }
    body {
      background-color: #606061;
      color: #ffffff;
    }
    img {
      border: none;
    }
    p {
      font-size: 1em;
      margin: 0 0 1em 0;
    }
    h2 {
      font-size: 14px;
      margin: 0 0 12px;
    }
    
    form {
      margin: 20px auto;
      width: 610px;
    }
    form fieldset {
      margin: 0 0 20px;
      padding: 20px;
      -webkit-border-radius: 5px;
      -moz-border-radius: 5px;
      border-radius: 5px;
    }
    form ol {
      list-style-type: none;
      padding: 0;
      margin: 0;
    }
    form li {
      margin: 0 0 12px;
      position: relative;
    }
    form label {
      width: 150px;
      display: inline-block;
      vertical-align: top;
    }
    form input, form textarea, form select {
      background: #fff;
      display: inline-block;
      width: 371px;
      border: 1px solid #fff;
      padding: 3px 26px 3px 3px;
      -moz-transition: background-color 1s ease;
      -webkit-transition: background-color 1s ease;
      -o-transition: background-color 1s ease;
      transition: background-color 1s ease;
      -webkit-border-radius: 5px;
      -moz-border-radius: 5px;
      border-radius: 5px;
    }
  CSS
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

get '/posts/new' do
  @form = PostForm.new(Post.new)
  erb :new_post
end

post '/posts' do
  @form = PostForm.new(Post.new)
  @form.submit params
  if @form.valid?
    @form.post.save
    raise @form.inspect
    redirect "/posts/#{@form.post.id}"
  else
    erb :new_post
  end
end

__END__

@@ layout
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/styles.css" media="screen" />
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ register
<h1>Register</h1>
<form action="/register" method="post">
  <%= Formation::Printer.new(@form).print %>
  <input type="submit" />
</form>

@@ thanks
<h1>Thanks!</h1>

@@ new_post
<h1>New Post</h1>
<form action="/posts" method="post">
  <%= Formation::Printer.new(@form).print %>
  <input type="submit" />
</form>