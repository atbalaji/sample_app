class AddCounterCache < ActiveRecord::Migration[5.1]
  def change
  	add_column :microposts, :likes_count, :integer, default: 0 	
  	add_column :users, :like_posts_count, :integer, default: 0
  end
end
