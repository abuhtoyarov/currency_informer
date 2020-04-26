class AddForcePriceToRate < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :force_price, :decimal, default: 0
  end
end
