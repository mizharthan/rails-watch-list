class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create, :index]

  def index
    @bookmarks = @list.bookmarks
  end

  def new
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: "Bookmark was successfully added."
    else
      flash.now[:alert] = @bookmark.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: "Bookmark was successfully removed."
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
