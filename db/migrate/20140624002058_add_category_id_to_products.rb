class AddCategoryIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
    remove_column :categories, :product_id, :integer
  end
end
