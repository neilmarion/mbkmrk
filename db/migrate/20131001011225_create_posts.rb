class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :message
      t.string :picture
      t.string :link
      t.string :source
      t.string :post_link

      t.timestamps
    end
  end
end
