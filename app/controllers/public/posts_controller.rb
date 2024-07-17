class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 画像のAI判断処理
    if post_params[:image].present?
      result = Vision.image_analysis(post_params[:image])
      if result == false
        flash.now[:alert] = "画像が不適切です。"
        render :new
        return
      end
    end

    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if post_params[:image].present?
      result = Vision.image_analysis(post_params[:image])
      if result == false
        flash.now[:alert] = "画像が不適切です。"
        render :edit
        return
      end
    end
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新に成功しました"
    else
      render :edit
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
