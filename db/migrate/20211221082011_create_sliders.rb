class CreateSliders < ActiveRecord::Migration[6.1]
  def change
    create_table :sliders do |t|
      t.string :name
      t.string :images

      t.timestamps
    end
  end
end
