module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'navbar-item  is-uppercase has-text-weight-bold' : 'navbar-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path, class: 'has-text-info has-text-weight-bold'
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friend_status(user)
    return if user == current_user

    link_to 'Add Friend',
            friendships_path(friendship: { user_id: current_user, friend_id: user.id, confirmed: false }),
            method: :post, class: 'add-friend '
  end

  def user_menu
    if user_signed_in?
      render '/layouts/dropdown_menu'
    else
      render '/layouts/sesion_buttons'
    end
  end

  def display_alert
    if notice.present?
      render '/layouts/notice'
    elsif alert.present?
      render '/layouts/alert'
    end
  end

  def counter
    current_user.inverted_friendships.length if current_user.inverted_friendships.length.positive?
  end
end
