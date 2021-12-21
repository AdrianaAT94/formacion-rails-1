class AddPositionToImage < ActiveRecord::Migration[6.1]
  def change    
    add_column :active_storage_attachments, :main, :boolean, null: false, default: false    
  end
end
