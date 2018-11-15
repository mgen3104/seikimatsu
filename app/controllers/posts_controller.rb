class PostsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @posts = Post.includes(:user).order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to controller: :posts, action: :index
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
    redirect_to controller: :posts, action: :index
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.update(post_params)
    redirect_to controller: :posts, action: :index
    end
  end

  def show
    @post = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  private
  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to :action => "index" unless user_signed_in?
  end
end
