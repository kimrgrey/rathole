class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.integer :reporter_id, null: false
      t.integer :post_id, null: false
      t.integer :author_id, null: false
      t.integer :state, default: 0
      t.text :note
      t.text :note_html
      t.text :tags, array: true, default: '{}'
      t.timestamp
    end
    add_index :bugs, :reporter_id
    add_index :bugs, :post_id
    add_index :bugs, :author_id
    add_index :bugs, :tags, using: 'gin'
  end
end
