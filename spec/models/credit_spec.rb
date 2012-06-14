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

describe Credit do
	let(:user) { FactoryGirl.create(:user) }
	before do
		@credit = user.credits.build(amount: "100.00", 
															 description: "bet with Jennifer", 
															 transaction_date: Time.now.to_date)
	end

	subject { @credit }

	it { should respond_to(:amount) }
	it { should respond_to(:description) }
	it { should respond_to(:transaction_date) }
	it { should respond_to(:user_id) }
	it { should be_valid }

	describe "when amount" do
		describe "is not present" do
			before { @credit.amount = "" }
			it { should_not be_valid }
		end

		describe "is an integer" do
			before { @credit.amount = "150" }
			it { should be_valid }
		end
		
		describe "is text" do
			before { @credit.amount = "nope" }
			it { should_not be_valid }
		end

		describe "has fractions of a cent" do
			before { @credit.amount = "150.001" }
			it { should_not be_valid }
		end
	end

	describe "when transaction_date" do
		describe "is a date string" do
			before { @credit.transaction_date = "2001/02/03" }
			it { should be_valid }
		end

		describe "is not a date" do
			before { @credit.transaction_date = "not a date" }
			it { should_not be_valid }
		end
	end

	describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Credit.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
end
