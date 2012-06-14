# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  budget     :integer         not null
#  name       :string(50)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Category do
	before { @category = Category.new(name: "Cats", budget: "150.00") }

	subject { @category }

	it { should respond_to(:name) }
	it { should respond_to(:budget) }
	it { should respond_to(:debits) }
	it { should be_valid }

	describe "when name" do
		
		describe "is not present" do
			before { @category.name = " " }
			it { should_not be_valid }
		end

		# todo: why does this fail?
		describe "is already taken" do
			before do
				category_with_same_name = @category.dup
				category_with_same_name.save
			end
			it { should_not be_valid }
		end
	end

	# todo: factor this out
	describe "when budget" do
		describe "is not present" do
			before { @category.budget = "" }
			it { should_not be_valid }
		end

		describe "is an integer" do
			before { @category.budget = "150" }
			it { should be_valid }
		end
		
		describe "is text" do
			before { @category.budget = "nope" }
			it { should_not be_valid }
		end

		describe "has fractions of a cent" do
			before { @category.budget = "150.001" }
			it { should_not be_valid }
		end
	end

	# todo: factor this out
	describe "debits" do
		before { @category.save }
		let(:user) { FactoryGirl.create(:user) }
		let!(:newer_debit) do
			FactoryGirl.create(:debit,
												 user: user,
												 category_id: @category.id, 
												 transaction_date: 1.hour.ago.to_date)
		end
		let!(:older_debit) do
			FactoryGirl.create(:debit, 
												 user: user,
												 category_id: @category.id, 
												 transaction_date: 1.day.ago.to_date)
		end
		let(:another_user) { FactoryGirl.create(:user) }
		let!(:debit_from_another_user) do 
			FactoryGirl.create(:debit,
												 user: another_user,
												 category_id: @category.id,
												 transaction_date: 2.days.ago.to_date)
		end

		it "should have debits from all users in the right order" do
			@category.debits.should == [newer_debit, older_debit, debit_from_another_user]
		end

		it "on destroy should not destroy associated debits" do
			debits = @category.debits
			@category.destroy
			debits.each do |debit|
				Debit.find_by_id(debit.id).should_not be_nil
			end
		end
	end
end
