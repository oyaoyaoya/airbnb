class RenameImageFileNameColumnToImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :photos, :image_file_name, :image
  end
end
