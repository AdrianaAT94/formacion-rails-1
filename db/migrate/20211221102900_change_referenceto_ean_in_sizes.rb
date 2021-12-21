class ChangeReferencetoEanInSizes < ActiveRecord::Migration[6.1]
  def change
    rename_column :sizes, :reference, :ean
  end
end
