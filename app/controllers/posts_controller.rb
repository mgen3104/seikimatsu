class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @posts = Post.includes(:user).order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    if post.save
      redirect_to action: :index
    else
      redirect_to :back, notice: "ケンシロウ「空欄のまま送信するようなババアがいるか。拳王の手下だな。」"
    end
  end

  def destroy
    if @post.user_id == current_user.id
      @post.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: '投稿を削除しました。' }
        format.js
      end
    end
  end

  def update
    if @post.user_id == current_user.id
      @post.update(post_params)
    redirect_to action: :index
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to :action => "index" unless user_signed_in?
  end
end
