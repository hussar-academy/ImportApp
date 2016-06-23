class CreateCategoryOperations < ActiveRecord::Migration
  def change
    create_table :category_operations do |t|

      t.references :category, index: true, foreign_key: true, null: false
      t.references :operation, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :category_operations, [:category_id, :operation_id], unique: true
  end
end
