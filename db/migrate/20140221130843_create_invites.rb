class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :token, null: false
      t.text :note
      t.timestamps
    end

    add_index :invites, :target_id, unique: true
  end
end
