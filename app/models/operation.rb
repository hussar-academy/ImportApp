class Operation < ActiveRecord::Base
  belongs_to :company, counter_cache: true
  has_many :category_operations
  has_many :categories, through: :category_operations

  validates :invoice_num, presence: true, uniqueness: true
  validates :amount, presence: true,  numericality: { greater_than: 0 }
  validates :invoice_date, :operation_date, :status, presence: true
end
