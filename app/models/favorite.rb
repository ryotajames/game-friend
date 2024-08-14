class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  has_many :notifications, dependent: :destroy

  private

  def create_notifications
    Notification.create(subject: self, post: self.post, customer: self.post.customer, action_type: :liked_to_own_post)
  end

end
