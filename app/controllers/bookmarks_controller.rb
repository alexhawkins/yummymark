class BookmarksController < ApplicationController
  
  def index
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    params[:bookmark][:topic_ids] ||= []
    @bookmark = current_user.bookmarks.build(bookmark_params)

    if @bookmark.save
        flash[:notice] = "Bookmark was saved."
        redirect_to topics_path
    else
        flash[:error] = "There was an error saving the answer. Please try again."
        render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    #set our paramater to an empty array if it's not set already.
    #if the following below returns nil, it will set it to an empty array.
    params[:bookmark][:topic_ids] ||= []
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark updated"
      #(redirect_to controller: 'topics', action: 'index')  is the same as below
      redirect_to topics_path
    else
      flash[:error] = "Trouble updating bookmark. Please try again."
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(
      :title, :url, 
      {:topic_ids => [] }
    )
  end

end