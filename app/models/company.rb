class Company < ActiveRecord::Base
  has_many :operations

  validates_presence_of :name
end
