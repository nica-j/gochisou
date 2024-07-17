class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @posts = Post.where(genre_id: @genre).all
  end
end
