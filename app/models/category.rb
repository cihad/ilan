class Category < ActiveRecord::Base
  # Validates
  validates :name, presence: true, uniqueness: true
end
