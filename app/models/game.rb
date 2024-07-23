class Game < ApplicationRecord
  has_many :posts
  belongs_to :customer
end
