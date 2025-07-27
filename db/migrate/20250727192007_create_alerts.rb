class CreateAlerts < ActiveRecord::Migration[8.0]
  def change
    create_table :alerts do |t|
      t.string :message
      t.datetime :received_at

      t.timestamps
    end
  end
end
