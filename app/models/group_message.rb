class GroupMessage < ApplicationRecord
  belongs_to :group
  belongs_to :customer
end
