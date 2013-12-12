class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :user_id
      t.integer :posts_count, default: 0
      t.timestamps
    end
  end
end
