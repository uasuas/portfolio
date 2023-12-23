class ContentLine < ApplicationRecord
  belongs_to :content
  belongs_to :line_plan

  validates :content_id, presence: true
end
