class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end
  
  
  private
  
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post)
    end
  end
  
  def post_params
    params.require(:post).permit(:user_id, :genre_id, :dish, :impression, :restaurant_name, :menu, :address, :image)
  end
end
