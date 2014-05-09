class TopicsController < ApplicationController
  
  def index
  end

  def create
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks.includes(:user)
  end
  
end
