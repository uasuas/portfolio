class PlanDetail < ApplicationRecord
  has_many :line_plans, dependent: :destroy

  validates :plan_code, presence: true
  validates :plan_text, presence: true
end
