FactoryBot.define do
  factory :event do
    association :user

    title { "TestEvent" }
    address { "TestEvent address" }
    description { "TestEvent description" }
    datetime { Time.now }

    factory :event_with_pin do
      pincode { '1111' }
    end
  end
end
