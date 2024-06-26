class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "新規作成に成功しました。"
    else
      @genres = Genre.all
      render 'index'
    end
  end
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path(@genre), notice: "変更が完了しました。"
    else
      render "edit"
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
