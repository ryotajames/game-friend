class Post < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  has_one :notification, as: :subject, dependent: :destroy

  validates :image, attached: true, content_type: ['image/png', 'image/jpeg']

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  enum status: {public: 0, private: 1 }, _prefix: true

  def self.looks(search, word)
    sanitized_word = ActiveRecord::Base.sanitize_sql_like(word)
    case search
    when "perfect_match"
      where("post_introduction LIKE ?", "#{sanitized_word}")
    when "forward_match"
      where("post_introduction LIKE ?", "#{sanitized_word}%")
    when "backward_match"
      where("post_introduction LIKE ?", "%#{sanitized_word}")
    when "partial_match"
      where("post_introduction LIKE ?", "%#{sanitized_word}%")
    else
      all
    end
  end

  def create_notification_like!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_customer.id, customer_id, id, 'like'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        post_id: id,
        visited_id: customer_id,
        action: 'like'
        )
      if notification.visitor_id == nogitication.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_customer, comment_id)
    temp_ids = Comment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_customer, comment_id, visited_id)
    notification = current_customer.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
