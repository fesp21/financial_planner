class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, :null => false, :limit => 50
      t.integer :cost, :null => false
      t.integer :rank, :null => false
      t.boolean :purchased, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :goals, :name, unique: true
    add_index :goals, :rank, unique: true
    add_foreign_key :goals, :users, :dependent => :delete
  end
end
