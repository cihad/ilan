class Category < ActiveRecord::Base
  DEFAULT_ICON = "bullhorn"

  # Validates
  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true

  # Associations
  has_many :nodes

  # Callbacks
  before_validation :default_icon

  private

  def default_icon
    self.icon = DEFAULT_ICON if icon.blank?
  end
end
