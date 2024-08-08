class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  belongs_to :end_customer

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, end_customer: self.post.end_customer, action_type: :liked_to_own_post)
  end

end
