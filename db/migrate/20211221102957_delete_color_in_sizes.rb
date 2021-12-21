class DeleteColorInSizes < ActiveRecord::Migration[6.1]
  def change
    remove_column :sizes, :color, :string
  end
end
