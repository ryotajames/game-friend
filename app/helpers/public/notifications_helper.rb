module Public::NotificationsHelper
  def transition_path(notification)
    case notification.action_type.to_sym
    when :commented_to_own_post
      post_path(notification.subject, anchor: "comment-#{notification.subject.id}")
    when :liked_to_own_post
      post_path(notification.subject)
    when :followed_me
      customer_path(notification.subject)
    end
  end
end