class DeleteDescriptionImagesInProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :description, :text
    remove_column :products, :images, :string
  end
end
