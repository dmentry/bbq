FactoryBot.define do
  factory :user do
    name { FFaker::Name.unique.name }

    email { FFaker::Internet.unique.email }

    # коллбэк - после фазы :build записываем поля паролей, иначе Devise не позволит :create юзера
    after(:build) { |u| u.password_confirmation = u.password = "123456" }
  end

  # factory :user_for_oauth do
  #   sequence(:email) { |n| "user#{n}@example.com" }
  #   password { "password" }
  #   password_confirmation { "password" }
  # end
end
