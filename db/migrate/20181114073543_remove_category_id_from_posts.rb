class RemoveCategoryIdFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :category_id, :integer
  end
end
