class Stop < ActiveRecord::Base
  # shim to our id for the stop_id in General Transit Feed Specification
  def stop_id
    id
  end
end
