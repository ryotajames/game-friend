class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
end
