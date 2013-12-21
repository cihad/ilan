class Category < ActiveRecord::Base
  # Validates
  validates :name, presence: true, uniqueness: true

  # Associations
  has_many :nodes
  
end
