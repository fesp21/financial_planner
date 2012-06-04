class ChangeDebitTransactionDateNotNull < ActiveRecord::Migration
  def change
  	change_column :debits, :transaction_date, :date, null: false
  end
end
