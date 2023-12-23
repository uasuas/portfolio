class AreaLine < ApplicationRecord
  belongs_to :area
  belongs_to :line_plan

  validates :area_id, presence: true
end
