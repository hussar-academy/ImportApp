class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :invoice_num, null: false
      t.date :invoice_date, null: false
      t.date :operation_date, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :reporter
      t.text :notes
      t.string :status, null: false
      t.string :kind, null: false

      t.timestamps null: false
    end
  end
end
