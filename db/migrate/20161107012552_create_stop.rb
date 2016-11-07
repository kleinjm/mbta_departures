class CreateStop < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.string :stop_name, null: false

      t.timestamps
    end
  end
end
