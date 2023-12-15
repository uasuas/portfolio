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

  def menu_areas
    if customer_signed_in?
      signed_nav_items_area
    end
  end

  def menu_contents
    if customer_signed_in?
      signed_nav_items_content
    end
  end

  private
  # 管理者用ヘッダー。
  def admin_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: admin_root_path,
        text: "管理者TOP"
      },
      {
        icon: "fa-solid fa-users",
        path: new_admin_company_path,
        text: "企業登録"
      },
      {
        icon: "fa-solid fa-book-open",
        path: new_admin_line_plan_path,
        text: "プラン登録"
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
        icon: "fa-solid fa-user",
        path: mypage_customers_path,
        text: "マイページ"
      },
      {
        icon: "fa-solid fa-building",
        path: companies_path,
        text: "回線会社一覧"
      },
      {
        icon: "fa-solid fa-book-open",
        path: line_plans_path,
        text: "回線プラン一覧"
      },
      {
        icon: "fa-solid fa-sign-out-alt",
        path: destroy_customer_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end
  def signed_nav_items_area
   area_items = []
    area = Area.all
    area.each do |area|
      area_items << {
        icon: "fa-solid fa-map-location-dot",
        path: search_path(content: area.area),
        text: area.area
      }
    end
    area_items
  end

  def signed_nav_items_content
    content_items = []
    content = Content.all
    content.each do |content|
      content_items << {
        icon: "fa-solid fa-house",
        path: search_path(content: content.content),
        text: content.content
      }
    end
    content_items
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
