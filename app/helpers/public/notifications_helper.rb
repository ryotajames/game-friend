module Public::NotificationsHelper
  def transition_path(notification)
    case notification.action_type.to_sym
    when :commented_to_own_post
      post_path(notification.subject.post_workout, anchor: "comment-#{notification.subject.id}")
    when :liked_to_own_post
      post_path(notification.subject.post_workout)
    when :followed_me
      customer_path(notification.subject.follower)
    end
  end
end