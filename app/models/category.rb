class Category < ActiveRecord::Base
  has_and_belongs_to_many :operations

  validates :name, presence: true

  def self.find_or_create_by_array(array)
    array.map { |name| Category.find_or_initialize_by(name: name) }
  end
end
