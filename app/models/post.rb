class Post < ActiveRecord::Base
  belongs_to :user
  serialize :latest_feed
  acts_as_taggable

  def self.graph
    @graph ||= Koala::Facebook::GraphAPI.new(access_token)
  end
 
  def self.update_posts_for_user!(user, opts={})
    @graph = Koala::Facebook::GraphAPI.new(user.access_token)
    @graph.get_connections("me", "feed")
    results = graph.get_connections(user.uid, 'feeds', opts)
    Rails.logger(results) 
  end
end
