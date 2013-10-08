class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  
  layout 'home'

  def index
    @posts = current_user.posts.order('created_at DESC')

  end
end
