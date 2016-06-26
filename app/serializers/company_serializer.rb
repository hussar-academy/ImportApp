class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :operations_count

  has_many :operations

  # def accepted_operations_count
  #   operations.where(status: 'accepted').count
  # end

  # def average_amount_of_operations
  #   operations.average(:amount)
  # end

  # def highest_operation_from_the_current_month
  #   date = DateTime.now
  #   operations.maximum(:amount, conditions: {operation_date: 
  #     (date.beginning_of_month..date.end_of_month)})
  # end
end
