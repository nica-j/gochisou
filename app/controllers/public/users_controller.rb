class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_state, only: [:show]
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]

  def mypage
    @user = current_user
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path(@user), notice: "ユーザー情報を更新しました"
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: "退会しました"
  end


  private
  
  def user_state
    user = User.find(params[:id])
    if user.is_active == true
    else
      redirect_to posts_path
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , alert: "会員登録が必要です"
    end
  end  

  def user_params
    params.require(:user).permit(:name, :introduction, :is_active, :image)
  end
end
