class Group < ApplicationRecord
  has_many :group_customers, dependent: :destroy
  has_many :customers, through: :group_customers, source: :customer, dependent: :destroy
  belongs_to :owner, class_name: 'Customer'
  has_many :customers, through: :group_customers
  has_many :group_messages, dependent: :destroy

  validates :group_name, presence: true
  validates :beginning, presence: true
  has_one_attached :group_image

  def is_owned_by?(customer)
    owner.id == custoemr.id
  end

  def get_group_image(width,height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end

  def includesCustomer?(customer)
    group_customers.exists?(customer_id: customer.id)
  end

  def self.looks(search, word)
    sanitized_word = ActiveRecord::Base.sanitize_sql_like(word)
    case search
    when "perfect_match"
      where("group_name LIKE ?", "#{sanitized_word}")
    when "forward_match"
      where("group_name LIKE ?", "#{sanitized_word}%")
    when "backward_match"
      where("group_name LIKE ?", "%#{sanitized_word}")
    when "partial_match"
      where("group_name LIKE ?", "%#{sanitized_word}%")
    else
      all
    end
  end

  def team_invitation_notification(current_customer, visited_id, team_id)
    temp = Notification.where(visitor_id: current_customer.id, visited_id: visited_id, team_id: team_id)
　　　　  # 上記で検索した通知がない場合のみ、通知レコードを作成。
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: visited_id,
        group_id: group_id,
        action: "invitation",
      )
      # エラーがなければ、通知レコードを保存。
      notification.save if notification.valid?
    end
  end


end
