class Company < ActiveRecord::Base
  has_many :operations, inverse_of: :company

  validates_presence_of :name
  validates_uniqueness_of :name
end
