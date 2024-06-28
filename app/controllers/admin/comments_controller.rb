class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
  end
end
