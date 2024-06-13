class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  # current_userしか使わないためあらかじめ全体に定義しておく
  before_action :set_current_user
  
  def mypage
  end

  def edit
  end
  
  def show
  end
  
  private
  
  def set_current_user
    @user = current_user
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :is_active)
  end
end
