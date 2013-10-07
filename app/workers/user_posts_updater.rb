class UserPostsUpdater
  @queue = :posts_queue

  def self.perform(user_id)
    user = User.find(user_id)
    Post.update_posts!(user)
  end
end
