class CreateDeparture < ActiveRecord::Migration[5.0]
  def change
    create_table :departures do |t|
      t.integer :origin_id, null: false
      t.string :trip
      t.integer :destination_id, null: false
      t.datetime :scheduled_time, null: false
      t.integer :lateness, default: 0
      t.integer :track_number
      t.string :status

      t.timestamps
    end
  end
end
