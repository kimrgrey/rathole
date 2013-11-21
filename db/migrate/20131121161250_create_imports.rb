class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :type
      t.string :state
      t.timestamps
    end
  end
end
