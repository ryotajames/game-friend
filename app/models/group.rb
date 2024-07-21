class Group < ApplicationRecord
  has_many :group_customers, dependent: :destroy
  has_many :customers, through: :group_customers, source: :customer
  belongs_to :owner, class_name: 'Customer'
  has_many :customers, through: :group_customers

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

end
