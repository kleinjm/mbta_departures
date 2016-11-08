# Models a single departure
class Departure < ApplicationRecord
  STATUSES = [
    'On Time', 'Cancelled', 'Arriving', 'End', 'Now Boarding',
    'Info to follow', 'Arrived', 'All Aboard', 'TBD', 'Departed', 'Delayed',
    'Late', 'Hold '
  ].freeze

  belongs_to :origin, foreign_key: 'origin_id', class_name: 'Stop'
  belongs_to :destination, foreign_key: 'destination_id', class_name: 'Stop'

  validates :origin_id, presence: true
  validates :destination_id, presence: true
  validates :scheduled_time, presence: true
  validates :status, inclusion: { in: STATUSES }

  validates :trip, uniqueness: { scope: [:origin_id, :destination_id] }
end
