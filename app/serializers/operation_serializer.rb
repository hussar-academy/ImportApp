class OperationSerializer < ActiveModel::Serializer
  attributes :id, :invoice_num, :invoice_date, :operation_date, :amount,
    :reporter, :notes, :status, :categories, :company

  def categories
    object.categories.pluck(:name).join(', ')
  end

  def company
    object.company.name
  end
end
