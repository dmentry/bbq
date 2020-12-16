class Event < ApplicationRecord
  #событие всегда принадлежит юзеру
  belongs_to :user

  has_many :comments
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  #Должен быть юзер
  validates :user, presence: true

  #должен быть заголовок <255 символов
  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true
end
