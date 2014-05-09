class Topic < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks
  has_and_belongs_to_many :users

  #sort alphabetically by title regardless of upcase or downcase
  default_scope { order('title ASC') }
end
 