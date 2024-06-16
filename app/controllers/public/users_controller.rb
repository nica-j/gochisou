class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @user = current_user
    @posts = @user.posts
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
    @posts = @user.posts
  end
  
  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path, notice: "退会が完了しました"
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :is_active, :image)
  end
end
