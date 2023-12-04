module ApplicationHelper
  def nav_items
    if admin_signed_in?
      admin_nav_items
    elsif customer_signed_in?
      signed_nav_items
    else
      guest_nav_items
    end
  end

  private
  # 管理者用ヘッダー。
  def admin_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: admin_root_path,
        text: "管理者用"
      },
      {
        icon: "fa-solid fa-users",
        path: root_path,
        text: "test"
      },
      {
        icon: "fa-solid fa-book-open",
        path: root_path,
        text: "test"
      },
      {
        icon: "fa-solid fa-sign-out-alt",
        path: destroy_admin_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end
  # ログイン後のヘッダー。
  def signed_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: mypage_customers_path,
        text: "ログイン後"
      },
      {
        icon: "fa-solid fa-users",
        path: root_path,
        text: "test"
      },
      {
        icon: "fa-solid fa-book-open",
        path: root_path,
        text: "test"
      },
      {
        icon: "fa-solid fa-sign-out-alt",
        path: destroy_customer_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end
  # ログイン前のヘッダー。
  def guest_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: root_path,
        text: "ログイン前"
      },
      {
        icon: "fa-solid fa-link",
        path: about_path,
        text: "About"
      },
      {
        icon: "fa-solid fa-user-plus",
        path: new_customer_registration_path,
        text: "新規登録"
      },
      {
        icon: "fa-solid fa-sign-in-alt",
        path: new_customer_session_path,
        text: "ログイン"
      }
    ]
  end
end
