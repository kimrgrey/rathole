class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.integer :reporter_id, null: false
      t.integer :post_id, null: false
      t.integer :state, default: 0
      t.text :fragment
      t.text :fragment_html
      t.text :note
      t.text :note_html
      t.timestamps
    end
    add_index :bugs, :reporter_id
    add_index :bugs, :post_id
  end
end
