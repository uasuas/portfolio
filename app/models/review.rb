class Review < ApplicationRecord
  belongs_to :coutomer
  belongs_to :line_plans

  validates :content, presence: true
end
