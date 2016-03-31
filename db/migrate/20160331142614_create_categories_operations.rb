class CreateCategoriesOperations < ActiveRecord::Migration
  def change
    create_table :categories_operations do |t|
      t.references :category
      t.references :operation
    end

    add_index :categories_operations, [:category_id, :operation_id]
  end
end
