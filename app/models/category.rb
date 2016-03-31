class Category < ActiveRecord::Base
  has_and_belongs_to_many :operations

  validates :name, presence: true
end
