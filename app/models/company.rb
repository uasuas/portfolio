class Company < ApplicationRecord
  has_many :line_plans, dependent: :destroy

  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  has_one_attached :image

  # imageが無い際の処理をしている。
  def get_company_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
