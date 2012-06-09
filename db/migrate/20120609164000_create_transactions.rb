class CreateTransactions < ActiveRecord::Migration
	def change
		create_table :transactions do |t|
			t.integer :amount, :null => false
			t.text :description
			t.integer :category_id
			t.date :transaction_date, :null => false
			t.integer :user_id, :null => false
			t.string :type, :null => false, :limit => 20

			t.timestamps
		end
		add_foreign_key :transactions, :users, :dependent => :delete
    add_foreign_key :transactions, :categories, :dependent => :nullify
    # move data from debits & credits to transactions
		User.all.each do |u|
			u.debits.all.each do |d|
				u.transactions.create!(amount: d.cost, description: d.description, category_id: d.category_id, transaction_date: d.transaction_date, type: 'Debit')
			end
			u.credits.all.each do |c|
				u.transactions.create!(amount: c.amount, description: c.description, transaction_date: c.transaction_date, type: 'Credit')
			end
		end
		# drop debits & credits
		drop_table :credits
		drop_table :debits
	end
end
