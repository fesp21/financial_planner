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
end
