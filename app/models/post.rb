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
    difference = results - User.latest_feed
    difference.each do |feed|
      user.posts.create(message: feed['message'], picture: feed['picture'], 
        link: feed['link'], source: feed['source'], name: feed['name'], 
        caption: feed['caption'])
    end
  end
end
