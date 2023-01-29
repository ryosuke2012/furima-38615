class CreateDeliveryTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_times do |t|

      t.timestamps
    end
  end
end
