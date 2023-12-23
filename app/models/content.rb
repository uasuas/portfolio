class Content < ApplicationRecord

  has_many :content_lines, dependent: :destroy
  has_many :line_plans, through: :content_lines
end
