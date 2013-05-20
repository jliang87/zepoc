class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps #created created_at and updated_at
    end
    add_index :posts, [:user_id, :created_at] #two indices
  end
end

