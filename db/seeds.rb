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

5.times do |n|
  Company.create(
    name: "test#{n + 1}",
    zip_code: "123456#{n + 1}",
    address: "adress#{n + 1}",
    telephone_number: "000012345#{n + 1}",
  )
end

# 診断結果用seed
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

# seedテスト用データの生成
areas.each do |area|
  Area.create(
    area: "#{area}"
  )
end
contents.each do |content|
  Content.create(
    content: "#{content}"
  )
end