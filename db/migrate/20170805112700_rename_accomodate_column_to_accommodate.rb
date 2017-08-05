class RenameAccomodateColumnToAccommodate < ActiveRecord::Migration[5.1]
  def change
    rename_column :rooms, :accomodate, :accommodate
  end
end
