# == Schema Information
#
# Table name: credits
#
#  id               :integer         not null, primary key
#  amount           :integer         not null
#  transaction_date :date            not null
#  description      :text
#  user_id          :integer         not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Credit < Transaction
end
