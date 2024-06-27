class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  # 会員のステータス変更処理のみ、万が一用にここでゲストを削除できないように
  def update
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to admin_user_path(@user), alert: "ゲストユーザーは削除できません"
    else
      @user.update(is_active: false)
      redirect_to admin_user_path(@user), notice: "退会が完了しました"
    end
  end

end
