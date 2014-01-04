class Image < ActiveRecord::Base

  # Validations
  validates :image, :node, presence: true

  # Associations
  belongs_to :node

  # Gem specific settings
  dragonfly_accessor :image

end
