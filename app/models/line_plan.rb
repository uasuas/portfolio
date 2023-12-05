class LinePlan < ApplicationRecord
  belongs_to :company
  belongs_to :plan_detail
  has_many :review, dependent: :destroy

  validates :name, presence: true
  validates :monthly_fee, presence: true
  validates :introduction, presence: true
end
