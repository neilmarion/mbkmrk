class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:index]
  
  def index
    @posts = current_user.posts.order('created_at DESC')

  end
end
