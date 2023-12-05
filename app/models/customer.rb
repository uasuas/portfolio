class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :is_active, inclusion: [true, false]

  # trueの場合のみログインを許可する。
  def active_for_authentication?
    super && (is_active == true)
  end
end
