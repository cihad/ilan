class Node < ActiveRecord::Base

  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  # Validates
  validates :title, :description, :contact, :email, :city, :category, presence: true
  validates_format_of :email, with: EMAIL_REGEXP, allow_blank: true,
                      if: :email_changed?

  # Associations
  belongs_to :city
  belongs_to :category



end
