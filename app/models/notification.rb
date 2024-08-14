class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  # belongs_to :subject, polymorphic: true

  belongs_to :customer, optional: true
  belongs_to :post, optional: true
  belongs_to :group, optional: true
  belongs_to :favorite, optional: true
  # 通知が訪問者と訪問先に関連付けられる（例: フォローやコメントの場合）
  belongs_to :visitor, class_name: 'Customer', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id'

  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 2, invitation: 3}

  def subject
    case action_type.to_sym
    when :commented_to_own_post, :followed_me, :invitation
      visitor
    when :liked_to_own_post
      visited
    else
      nil
    end
  end

end
