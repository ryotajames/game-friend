class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name]

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true, presence: true

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :favorites, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_customers, dependent: :destroy
  has_many :groups, through: :group_customers

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :rooms, dependent: :destroy

  has_many :games, dependent: :destroy

  # has_many :notifications, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


  has_one_attached :profile_image
  # has_many :yyy, through: :xxx, source: :zzz

  # 検索方法分岐
  def self.looks(search, word)
    sanitized_word = ActiveRecord::Base.sanitize_sql_like(word)
    case search
    when "perfect_match"
      where("name LIKE ?", "#{sanitized_word}")
    when "forward_match"
      where("name LIKE ?", "#{sanitized_word}%")
    when "backward_match"
      where("name LIKE ?", "%#{sanitized_word}")
    when "partial_match"
      where("name LIKE ?", "%#{sanitized_word}%")
    else
      all
    end
  end

  def follow(customer, current_customer)
    relationship = Relationship.new
    relationship.visited_id = customer.id
    relationship.followed_id = customer.id
    relationship.follower_id = current_customer.id

    relationship.save
  end

  def unfollow(customer)
    active_relationships.find_by(visited_id: customer.id).destroy
  end

  def following?(customer)
    followings.include?(customer)
  end

  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def create_notification_follow!(current_customer)
  temp = Notification.where(["visitor_id = ? AND visited_id = ? AND action_type = ?", current_customer.id, id, 'follow'])
    if temp.blank?
      notification = Notification.new(
        visitor_id: current_customer.id,
        visited_id: id,
        action_type: 2
      )
      notification.save if notification.valid?
    end
  end

  # def active_notifications(visitor_id, visited_id, group_id)
  # notification = Notification.new(
  #   visitor_id: visitor_id,
  #   visited_id: visited_id,
  #   group_id: group_id,
  #   action_type: 'invitation'
  # )
  # notification.save if notification.valid?
  # end


end
