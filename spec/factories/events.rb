FactoryBot.define do
  factory :event do
    association :user

    title { "TestEvent" }
    address { "TestEvent address" }
    datetime { Time.now }

    factory :event_with_pin do
        pincode { 0000 }
    end
  end
end
