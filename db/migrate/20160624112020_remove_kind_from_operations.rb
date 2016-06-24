class RemoveKindFromOperations < ActiveRecord::Migration
  def change
    remove_column :operations, :kind, :string, null: false
  end
end
