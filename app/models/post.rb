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

  def create_notification_like!(target_customer)
    temp = Notification.where(["visited_id = ? and post_id = ? and action_type = ? ", target_customer.id, id, 'like'])
    if temp.blank?
      notification = Notification.new(
        post_id: id,
        visited_id: customer_id,
        visitor_id: target_customer.id,
        action_type: 1
        )
      # if notification.customer_id == notification.customer_id
      #   notification.checked = true
      # end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_customer, comment_id)
  temp_ids = Comment.select(:customer_id).where(post_id: id).where.not(customer: current_customer).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id.customer_id)
    end
  save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end


  def save_notification_comment!(current_customer, comment_id, visited_id)
    return unless current_customer
    notification = current_customer.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: customer_id,
      action_type: 0
    )
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
    notification.save if notification.valid?
  end

end
