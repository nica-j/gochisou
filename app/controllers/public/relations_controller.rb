class Public::RelationsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end
  
  #一覧表示
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
end
