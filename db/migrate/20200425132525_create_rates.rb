class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.decimal :price, default: 0
      t.datetime :force_date_time

      t.timestamps
    end
  end
end
