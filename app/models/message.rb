class Message < ApplicationRecord
  belongs_to :customer
  belongs_to :room

  validates :body, presence: true

end
