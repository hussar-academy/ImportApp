class Company < ActiveRecord::Base
  has_many :operations

  validates :name, presence: true
end
