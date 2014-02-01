class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.string :code
      t.string :picture
      t.timestamps
    end
  end
end
