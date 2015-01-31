class DropStatisticalRecords < ActiveRecord::Migration
  def change
    drop_table :statistical_records
  end
end
