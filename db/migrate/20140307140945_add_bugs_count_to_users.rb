class AddBugsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bugs_count, :integer, default: 0
  end
end
