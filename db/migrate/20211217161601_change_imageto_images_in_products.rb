class ChangeImagetoImagesInProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :image, :images
  end
end
