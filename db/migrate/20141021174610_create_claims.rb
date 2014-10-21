class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.text :body, default: ''
      t.integer :post_id
      t.timestamps
    end
  end
end
