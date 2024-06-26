class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = post.id
    @comment.save
  end
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
