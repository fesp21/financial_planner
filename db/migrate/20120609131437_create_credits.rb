class CreateCredits < ActiveRecord::Migration
	def change
		create_table :credits do |t|
			t.integer :amount, :null => false
			t.date :transaction_date, :null => false
			t.text :description
			t.integer :user_id, :null => false

			t.timestamps
		end
		add_foreign_key :credits, :users, :dependent => :delete
	end
end
