class ReworkImports < ActiveRecord::Migration
  def change
    change_table :imports do |t|
      t.remove :type
      t.remove :state
      t.string :lj_user
      t.integer :state, default: 0
    end
  end
end
