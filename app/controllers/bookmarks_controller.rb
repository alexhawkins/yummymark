class BookmarksController < ApplicationController
  respond_to :html, :js
  
  def index
  end

  def new
    @bookmark = Bookmark.new
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    params[:bookmark][:topic_ids] ||= []
    @bookmark = current_user.bookmarks.build(bookmark_params)
    #get the user input from the topic field and split the words into an array called topics
    add_these_topics = params[:topic_field].gsub(/[^a-zA-Z]/, ' ').downcase.split
    #now iterate through each topic in our array and associate them with the bookmark we're creating
      add_these_topics.each do |topic_title|
        #find our title in our Topics class if it exists, otherwise create the topic
        topic = Topic.find_or_create_by_title(topic_title)
        #we then associate the topics with our bookmark
        @bookmark.topics << topic
        #check to make sure this topic has not already been associated with this user
        unless current_user.topics.include?(topic)
          #associate topics with user 
          current_user.topics << topic
        end
      end

    #Get embedly image url
    embedly_api = 
      Embedly::API.new key: ENV['EMBEDLY_KEY'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; alexhawkins.me@gmail.com)'

    @bookmark.image_url = embedly_api.oembed(url: @bookmark.url).first.thumbnail_url

    if @bookmark.save
        UserMailer.bookmark_created_email(current_user, @bookmark).deliver
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

     #Get embedly image url
    embedly_api = 
      Embedly::API.new key: ENV['EMBEDLY_KEY'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; alexhawkins.me@gmail.com)'

    @bookmark.image_url = embedly_api.oembed(url: @bookmark.url).first.thumbnail_url
    
    if @bookmark.update_attributes(bookmark_params)
      flash[:notice] = "Bookmark updated"
      #(redirect_to controller: 'topics', action: 'index')  is the same as below
      redirect_to topics_path
    else
      flash[:error] = "Trouble updating bookmark. Please try again."
      render :new
    end
  end

  def destroy 
    @bookmark = Bookmark.find(params[:id])
    @bookmark_ids = @bookmark.topic_ids.join("")
    Rails.logger.info "Should remove bookmark-#{@bookmark_ids}"
    title = @bookmark.title
    if @bookmark.destroy
      #flash[:notice] = "\"#{title}\" was deleted successfully."
      #redirect_to :back
    else
      #flash[:error] = "There was an error deleting the post."
      #redirect_to :back
    end
    
    respond_with(@bookmark) do |format|
      format.html { redirect_to @bookmark }
      format.js
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