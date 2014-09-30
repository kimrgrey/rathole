class AddNoteUpdatedAtToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :note_updated_at, :timestamp
  end
end
