FactoryGirl.define do
  factory :departure do
    origin_id(-1)
    destination_id(-1)
    scheduled_time 1.day.from_now
    status Departure::STATUSES.first

    # if we're persiting, create the related objects to pass validation
    before(:create) do |departure|
      departure.origin = create :stop
      departure.destination = create :stop
    end
  end
end
