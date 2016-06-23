class CategoryOperation < ActiveRecord::Base
  belongs_to :category
  belongs_to :operation

  validates :category, :operation, presence: true
end
