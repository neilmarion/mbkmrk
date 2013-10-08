class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :uid
      t.text :message
      t.text :picture
      t.text :link
      t.text :source
      t.text :post_link

      t.timestamps
    end
  end
end
