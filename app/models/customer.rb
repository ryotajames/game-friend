class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :relationships, class_name: "relationships", foreign_key: "relationship_id", dependent: :destroy
  has_many :favorites
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :group_customers, dependent: :destroy
  # has_many :yyy, through: :xxx, source: :zzz
end
