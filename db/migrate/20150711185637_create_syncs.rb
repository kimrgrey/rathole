class CreateSyncs < ActiveRecord::Migration
  def change
    create_table :syncs do |t|
      t.timestamp :lsd, :null => false
      t.timestamp :next_lsd, :null => false
      t.integer :post_id
      t.string :token, :null => false
      t.integer :attempts_count, :null => false, :default => 0
      t.text :result
      t.boolean :finished, :null => false, :default => "false"
      t.timestamps
    end

    add_index :syncs, :token, :unique => true
  end
end
