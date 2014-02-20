class CreateStatisticalRecords < ActiveRecord::Migration
  def change
    create_table :statistical_records do |t|
      t.integer :users_count, default: 0
      t.integer :posts_count, default: 0
      t.integer :comments_count, default: 0
      t.integer :events_count, default: 0
      t.date :date
      t.timestamps
    end

    add_index :statistical_records, :date, unique: true
  end
end
