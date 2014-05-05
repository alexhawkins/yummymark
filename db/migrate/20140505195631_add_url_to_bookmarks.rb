class AddUrlToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :url, :string
  end
end
