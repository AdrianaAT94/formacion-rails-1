class AddTotaltoOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total, :numeric, null: false, default: false    
  end
end
