class Operation < ActiveRecord::Base
  belongs_to :company, inverse_of: :operations

  has_many :categorizations
  has_many :categories, through: :categorizations

  validates_presence_of :invoice_num, :invoice_date, :amount,
                        :operation_date, :status

  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num
end
