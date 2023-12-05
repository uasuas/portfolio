class Company < ApplicationRecord
  has_many :line_plans, dependent: :destroy

  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
end
