class CreateTopicsUsers < ActiveRecord::Migration
  def change
    create_table :topics_users, :id => false do |t|
      t.references :topic, index: true
      t.references :user, index: true
    end
  end
end
