class CreateDebits < ActiveRecord::Migration
  def change
    create_table :debits do |t|
      t.integer :cost, :null => false
      t.text :description
      t.integer :category_id
      t.date :transaction_date
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_foreign_key :debits, :users, :dependent => :delete
    add_foreign_key :debits, :categories
  end
end
