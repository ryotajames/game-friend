class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: 'Customer'
  has_many :customers, through: :group_customers

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def is_owned_by?(customer)
    owner.id == custoemr.id
  end

end
