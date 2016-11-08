FactoryGirl.define do
  factory :stop do
    sequence(:stop_name) { |n| "Name-#{n}" }
  end
end
