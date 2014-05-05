require 'spec_helper'

feature 'User visits Bookmarks index' do
  scenario 'Successfully' do
    visit bookmarks_path
  end
end