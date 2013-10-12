class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable

  validates_presence_of :uid
  validates_presence_of :tag_list
  validates_uniqueness_of :link
  validates_presence_of :title

  def self.update_posts!(user, opts={})
    @graph = Koala::Facebook::API.new(user.access_token)
    results = @graph.get_connections('me', 'feed')

    difference = results - user.latest_feed
    difference.each do |feed|
      tags = feed['message'] ? feed['message'].scan(/#\S+/) : []
      unless tags.blank?
        user.posts.find_or_create_by_uid(feed['id']) do |p|
          p.uid = feed['id']
          p.title = feed['name']
          p.message = feed['message']
          p.picture = feed['picture'] 
          p.link = feed['link']
          p.source = feed['source']
          p.tag_list = tags.join(',')        
        end
      end
    end

    user.update_attributes(latest_feed: results)
  end
end
