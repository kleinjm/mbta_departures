class Stop < ActiveRecord::Base
  validates :stop_name, uniqueness: true

  # shim to our id for the stop_id in General Transit Feed Specification
  def stop_id
    id
  end
end
