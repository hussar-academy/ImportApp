class OperationSerializer < ActiveModel::Serializer
  attributes :id, :invoice_num, :invoice_date, :operation_date, :amount,
    :reporter, :notes, :status, :categories, :company

  has_many :categories

  def company
    object.company.name
  end
end
