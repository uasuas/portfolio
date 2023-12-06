# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者用seed
Admin.create(
  email: "admin@admin",
  password: "adminadmin",
)

# 診断結果用seed
areas = {
  "東京" => "１",
  "千葉" => "２",
  "埼玉" => "３",
  "神奈川" => "４",
  "群馬" => "５",
  "栃木" => "６",
  "茨城" => "７",
  "山梨" => "８"
}

# 内容
contents = {
  "テレビ回線" => "１",
  "インターネット回線" => "２",
  "電話回線" => "４",
  "テレビ回線・インターネット回線" => "３",
  "テレビ回線・電話回線回線" => "５",
  "インターネット回線・電話回線" => "６",
  "テレビ回線・インターネット回線・電話回線" => "７"
}

# 料金
prices = {
  "1,000円〜2,000円" => "１",
  "2,001円〜3,000円" => "２",
  "3,001円〜4,000円" => "３",
  "4,001円〜5,000円" => "４",
  "5,001円〜6,000円" => "５",
  "6,000円~" => "6",
}

# seedテスト用データの生成
areas.each do |area_name, area_code|
  contents.each do |content_name, content_code|
    prices.each do |price_range, price_code|
      # シードデータの作成
      PlanDetail.create(
        plan_code: "#{area_code}#{content_code}#{price_code}",
        plan_text: "こちらは#{area_name}/#{content_name}/料金プランは#{price_range}のご契約プランです。",
      )
    end
  end
end