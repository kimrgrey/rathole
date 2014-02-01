class CreateUsersStickers < ActiveRecord::Migration
  def change
    create_table :stickers_users do |t|
      t.integer :user_id
      t.integer :sticker_id
      t.timestamp
    end
  end
end
