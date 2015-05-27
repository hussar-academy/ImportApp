class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_reference :operations, :company, index: true
  end
end
