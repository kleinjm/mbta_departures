FactoryGirl.define do
  factory :departure do
    origin_id(-1)
    destination_id(-1)
    scheduled_time 1.day.from_now
  end
end
