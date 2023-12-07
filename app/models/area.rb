class Area < ApplicationRecord

  has_many :area_lines, dependent: :destroy
  has_many :line_plans, through: :area_lines

  # validates :area, presence: true
end
