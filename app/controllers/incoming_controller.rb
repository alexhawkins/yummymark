class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"

    # You put the message-splitting and business
    # magic here.
    @sender  = params['from']
    @subject = params['subject'] 
    @body_url = params['stripped-text']

    #@bookmark = Bookmark.new
    @bookmark = current_user.bookmarks.build(bookmark_params)
    @bookmark.url = @body_url
    #@bookmark.title 
    #get the user input from the topic field and split the words into an array called topics
    add_these_topics = @subject.gsub(/[^a-zA-Z]/, ' ').downcase.split
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
    if @bookmark.save
        flash[:notice] = "Bookmark was saved."
        redirect_to topics_path
    else
        flash[:error] = "There was an error saving the answer. Please try again."
        render :new
    end

    # Assuming all went well. 
    head 200
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(
      :title, :url, 
      {:topic_ids => [] }
    )
  end

end