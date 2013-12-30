class Node < ActiveRecord::Base

  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  # Validates
  validates :title, :description, :contact, :email, :city, :category, presence: true
  validates_format_of :email, with: EMAIL_REGEXP, allow_blank: true,
                      if: :email_changed?

  # Associations
  belongs_to :city
  belongs_to :category

  # Scopes
  scope :published, -> { where(status: "published") }
  default_scope { order(updated_at: :desc) }

  # Workflow
  include Workflow
  workflow_column :status
  workflow do
    state :pending_approval do
      event :publish, :transitions_to => :published
      event :reject, :transitions_to => :rejected
    end

    state :published do
      event :expire, :transitions_to => :expired
    end

    state :expired
    state :rejected
  end

  def publish
    NodeStatusMailer.published(self).deliver!
  end

  def reject reason = ""
    NodeStatusMailer.rejected(self, reason).deliver!
  end

  def expire
    NodeStatusMailer.expired(self).deliver!
  end

  def self.group_by_category city
    unscoped.
      select(:id, :title, :category_id).
        includes(:category).
          where(city_id: city.id).
            published.
              order(updated_at: :desc).
                group_by do |n|
                  n.category
                end
  end

end
