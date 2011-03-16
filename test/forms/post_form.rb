class PostForm
  
  include Formation::Form
  
  resource :post do
    field :title
    field :body, :type => :textarea
  end
  
  field 'author[name]'
  
  def initialize(post)
    @post = post
  end
  
end