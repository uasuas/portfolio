class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :line_plan

  validates :content, presence: true
end
