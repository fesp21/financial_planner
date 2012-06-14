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

describe Debit do
	let(:user) { FactoryGirl.create(:user) }
	let(:category) { FactoryGirl.create(:category) }
	before do
		@debit = user.debits.build(cost: "100.00", 
															 description: "too many groceries", 
															 category_id: category.id,
															 transaction_date: Time.now.to_date)
	end

	subject { @debit }

	it { should respond_to(:cost) }
	it { should respond_to(:description) }
	it { should respond_to(:category_id) }
	it { should respond_to(:transaction_date) }
	it { should respond_to(:user_id) }
	it { should be_valid }

	describe "when cost" do
		describe "is not present" do
			before { @debit.cost = "" }
			it { should_not be_valid }
		end

		describe "is an integer" do
			before { @debit.cost = "150" }
			it { should be_valid }
		end
		
		describe "is text" do
			before { @debit.cost = "nope" }
			it { should_not be_valid }
		end

		describe "has fractions of a cent" do
			before { @debit.cost = "150.001" }
			it { should_not be_valid }
		end
	end

	describe "when transaction_date" do
		describe "is a date string" do
			before { @debit.transaction_date = "2001/02/03" }
			it { should be_valid }
		end

		describe "is not a date" do
			before { @debit.transaction_date = "not a date" }
			it { should_not be_valid }
		end
	end

	describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Debit.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
