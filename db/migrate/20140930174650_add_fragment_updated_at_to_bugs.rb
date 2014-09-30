class AddFragmentUpdatedAtToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :fragment_updated_at, :timestamp
  end
end
