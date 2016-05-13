class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :operations, through: :categorizations

  validates_presence_of :name
  validates_uniqueness_of :name
end
