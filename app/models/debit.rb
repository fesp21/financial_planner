# == Schema Information
#
# Table name: debits
#
#  id               :integer         not null, primary key
#  cost             :integer         not null
#  description      :text
#  category_id      :integer
#  transaction_date :date
#  user_id          :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Debit < Transaction
end
