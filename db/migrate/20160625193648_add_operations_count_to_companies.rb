class AddOperationsCountToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :operations_count, :integer, null: false, default: 0
    Company.reset_column_information
    Company.find_each do |company|
      Company.reset_counters company.id, :operations
    end
  end
end
