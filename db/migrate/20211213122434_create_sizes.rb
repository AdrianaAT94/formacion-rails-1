class CreateSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :sizes do |t|
      t.string :name
      t.string :ean
      t.decimal :price
      t.integer :stock
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
