class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  validates_presence_of :tag_list


  def self.update_posts!(user, opts={})
    @graph = Koala::Facebook::API.new(user.access_token)
    results = @graph.get_connections('me', 'feed')

    difference = results - user.latest_feed
    difference.each do |feed|
      tags = feed['message'] ? feed['message'].scan(/#\S+/) : []
      unless tags.blank?
        user.posts.create(message: feed['message'], picture: feed['picture'], 
          link: feed['link'], source: feed['source'], tag_list: tags.join(','))
      end
    end

    user.update_attributes(latest_feed: results)
  end
end
