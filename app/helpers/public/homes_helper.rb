module Public::HomesHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def nav_items
    if admin_signed_in?
      admin_nav_items
    elsif user_signed_in?
      user_nav_items
    else
      guest_nav_items
    end
  end


  private
  def admin_nav_items
    [
      {
        type: "link",
        path: admin_root_path,
        text: "SNS"
      },
      {
        type: "link",
        path: admin_users_path,
        text: "会員一覧"
      },
      {
        type: "link",
        path: admin_requests_path,
        text: "お問い合わせ"
      },
      {
        type: "link",
        path: destroy_admin_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end

  def user_nav_items
    [
      {
        type: "pop_up",
        path: new_request_path,
        text: "お問い合わせ"
      },
      {
        type: "link",
        path: about_path,
        text: "About"
      },
      {
        type: "link",
        path: posts_path,
        text: "SNS"
      },
      {
        type: "link",
        path: destroy_user_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end

  def guest_nav_items
    [
      {
        type: "pop_up",
        text: "お問い合わせ",
        class: "guest-request"
      },
      {
        type: "link",
        path: about_path,
        text: "About"
      },
      {
        type: "link",
        path: new_user_registration_path,
        text: "新規登録"
      },
      {
        type: "pop_up",
        text: "ログイン",
        class: "guest-login"
      }
    ]
  end
end
