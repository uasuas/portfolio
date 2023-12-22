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
  # 電話番号の表示を変更し呼び出せるようにする。
  # 電話番号の文字列内の数字を3桁、4桁、4桁の3つのグループに分け間に"-"を設置。
  def format_telephone_number(telephone_number)
    telephone_number.gsub(/(\d{3})(\d{4})(\d{4})/, '\1-\2-\3')
  end
  # 郵便番号の表示を変更し呼び出せるようにする。
  # 郵便番号が存在しかつ、7文字かをチェック。
  def format_zip_code(zip_code)
    zip_code.to_s.insert(3, "-") if zip_code.present? && zip_code.length == 7
  end
  # 月額料金の表示を変更し呼び出せるようにする。
  def format_monthly_fee(amount)
    number_with_delimiter(amount, delimiter: ',') if amount.present?
  end
  # テキスト量が多いものを制限したい際に使用。
  def custom_truncate(text, length = 15, omission = '...')
    truncate(text, length: length, omission: omission)
  end

  private
  # サイドバーに表示するナビゲーションアイテムのエリアをarea_itemsに格納して表示内容を作成。
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
  # サイドバーに表示するナビゲーションアイテムのエリアをcontent_itemsに格納して表示内容を作成。
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

  # 管理者用ヘッダー。
  def admin_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: admin_root_path,
        text: "管理者Top"
      },
      {
        icon: "fa-solid fa-folder-plus",
        path: new_admin_company_path,
        text: "企業登録"
      },
      {
        icon: "fa-solid fa-file-circle-plus",
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
        path: root_path,
        text: "Topページ"
      },
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
  # ログイン前のヘッダー。
  def guest_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: root_path,
        text: "Topページ"
      },
      {
        icon: "fa-solid fa-link",
        path: about_path,
        text: "Aboutページ"
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
