class CreateTableOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    create_table :line_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
