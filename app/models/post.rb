class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  validates_presence_of :tag_list

end
