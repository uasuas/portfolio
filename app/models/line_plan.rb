class LinePlan < ApplicationRecord
  belongs_to :company
  has_many :reviews, dependent: :destroy
  has_many :area_lines, dependent: :destroy
  has_many :areas, through: :area_lines
  has_many :content_lines, dependent: :destroy
  has_many :contents, through: :content_lines

  validates :name, presence: true
  validates :monthly_fee, presence: true
  validates :introduction, presence: true
end
