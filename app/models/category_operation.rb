class CategoryOperation < ActiveRecord::Base
  belongs_to :category
  belongs_to :operation, autosave: true

  validates :category, :operation, presence: true
end
