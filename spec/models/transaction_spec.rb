# == Schema Information
#
# Table name: transactions
#
#  id               :integer         not null, primary key
#  amount           :integer         not null
#  description      :text
#  category_id      :integer
#  transaction_date :date            not null
#  user_id          :integer         not null
#  type             :string(20)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'spec_helper'

describe Transaction do
  pending "add some examples to (or delete) #{__FILE__}"
end
