Formation
=========

`formation` is a ruby library for building, validating, and extending forms.

Simple:

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

Model:

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

### Validating
...

### Printing
...

### Extending
...