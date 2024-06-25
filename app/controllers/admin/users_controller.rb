class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  # 会員のステータス変更処理のみ
  def update
    @user = User.find(params[:id])
    @user.update(is_active: false)
    redirect_to admin_user_path(@user), notice: "退会が完了しました"
  end

end
