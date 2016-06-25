class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :operations_count, :accepted_operations_count,
    :average_amount_of_operations, :highest_operation_from_the_current_month

  has_many :operations

  def operations_count
    operations.count
  end

  def accepted_operations_count
    operations.where(status: 'accepted').count
  end

  def average_amount_of_operations
    operations.average(:amount)
  end

  def highest_operation_from_the_current_month
    date = DateTime.now
    operations.maximum(:amount, conditions: {operation_date: 
      (date.beginning_of_month..date.end_of_month)})
  end

  private

  def operations
    @operations ||= object.operations
  end
end
