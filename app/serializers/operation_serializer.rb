class OperationSerializer < ActiveModel::Serializer
  attributes :id, :invoice_num, :invoice_date, :operation_date, :amount,
    :reporter, :notes, :status, :categories

  belongs_to :company

  def categories
    object.categories.pluck(:name).join(', ')
  end
end
