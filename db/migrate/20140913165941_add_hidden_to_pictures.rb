class AddHiddenToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :hidden, :boolean, default: false
  end
end
