# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# find_or_create_by
# 管理者用seed
admin = Admin.create(
  email: "admin@admin",
)
if admin.new_record?
  admin.password = "adminadmin"
  admin.save!
end


# エリア
areas = [
  "東京",
  "千葉",
  "埼玉",
  "神奈川",
  "群馬",
  "栃木",
  "茨城",
]

# 内容
contents = [
  "テレビ",
  "インターネット",
  "電話",
]

# エリアと内容のデータを生成する
areas.each do |area|
  Area.create(area: area)
end

contents.each do |content|
  Content.create(content: content)
end

5.times do |n|
  company = Company.create(
    name: "サンプル企業#{n + 1}",
    zip_code: "123456#{n + 1}",
    address: "東京都新宿区#{n + 1}",
    telephone_number: "0120123456#{n + 1}",
  )
  # LinePlan（ラインプラン）のデータを作成
  line_plan = LinePlan.create(
    name: "サンプルラインプラン#{n + 1}",
    monthly_fee: 5000 + (n * 1000), # 月額料金を適宜変更
    introduction: "サンプルのプラン内容#{n + 1}",
    company: company
  )

  # エリアとコンテンツの関連付け
  areas.sample(3).each do |area|
    line_plan.areas << Area.find_by(area: area)
  end

  contents.sample(2).each do |content|
    line_plan.contents << Content.find_by(content: content)
  end
end

5.times do |n|
  Customer.create(
    name: "サンプルname#{n + 1}",
    email: "test#{n + 1}@mail",
    password: "111111",
    is_active: true
  )
end