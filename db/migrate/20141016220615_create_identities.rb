class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.integer :user_id, null: false
      t.string :uuid, null: false
      t.string :provider, null: false
      t.timestamps
    end

    add_index :identities, :user_id
    add_index :identities, [:uuid, :provider]
  end
end
