class RemoveImagesFromSlider < ActiveRecord::Migration[6.1]
  def change
    remove_column :sliders, :images, :string
  end
end
