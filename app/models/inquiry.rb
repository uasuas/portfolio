class Inquiry < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true
  validates :status, inclusion: [true, false]
end
