class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :post

  has_many :notifications, dependent: :destroy

  private

  def create_notifications
    Notification.create(subject: self, customer: post.customer, action_type: :commented_to_own_post)
  end

end
