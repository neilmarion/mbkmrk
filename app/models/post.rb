class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  def self.graph
    @oauth = Koala::Facebook::OAuth.new(FACEBOOK['key'], FACEBOOK['secret'], FACEBOOK['callback_url'])
    @graph ||= Koala::Facebook::GraphAPI.new(access_token)
  end
 
  def self.update_posts_for_user!(user, opts={})
    results = graph.get_connections(user.uid, 'feeds', opts)
    Rails.logger(results) 
  end
end
