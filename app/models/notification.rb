class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  #belongs_to :post, optional: true
  #belongs_to :comment, optional: true
  belongs_to :subject, polymorphic: true 
  
  belongs_to :customer

  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 3}

  belongs_to :visitor, class_name: 'Customer', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id', optional: true
end
