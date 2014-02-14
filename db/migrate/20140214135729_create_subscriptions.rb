class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id
      t.integer :author_id
      t.integer :post_id
      t.timestamps
    end
  end
end
