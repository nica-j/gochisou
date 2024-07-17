class Public::SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    
    if @model  == "user"
      @records = User.where('name LIKE ?', '%' + @content + '%')
    else
      @records = Post.where('dish LIKE ?', '%' + @content + '%')
    end
  end
end
