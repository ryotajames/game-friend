class GroupMessage < ApplicationRecord
  belongs_to :group
  belongs_to :customer

  validates :body, presence: true

end
