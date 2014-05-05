class CreateBookmarksTopicsJoin < ActiveRecord::Migration
  def change
    create_table :bookmarks_topics, :id => false do |t|
      t.references :bookmark, index: true
      t.references :topic, index: true
    end
  end
end
