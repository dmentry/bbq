class User < ApplicationRecord
  EMAIL = /\A\w+@\w+\.\w+\z/

  has_many :events

  validates :name, presence: true, length: {maximum: 35}
  validates :email, presence: true, uniqueness: true, length: {maximum: 255}, format: { with: EMAIL }
end
