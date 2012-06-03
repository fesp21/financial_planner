# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)     not null
#  email           :string(255)     not null
#  password_digest :string(255)     not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe User do
	before do
		@user = User.new(name: "Mr Fake",
										 email: "fake@example.com",
										 password: "foobar",
										 password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:debits) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end      
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end      
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "debits" do
		before { @user.save }
		let(:category) { FactoryGirl.create(:category) }
		let!(:newer_debit) do
			FactoryGirl.create(:debit,
												 user: @user,
												 category_id: category.id, 
												 transaction_date: 1.hour.ago.to_date)
		end
		let!(:older_debit) do
			FactoryGirl.create(:debit, 
												 user: @user,
												 category_id: category.id, 
												 transaction_date: 1.hour.ago.to_date)
		end
		let(:another_user) { FactoryGirl.create(:user) }
		let!(:debit_from_another_user) do 
			FactoryGirl.create(:debit,
												 user: another_user,
												 category_id: category.id,
												 transaction_date: 2.days.ago.to_date)
		end

		it "should have the right debits in the right order" do
			@user.debits.should == [newer_debit, older_debit]
		end

		it "should not have debits from another user" do
			@user.debits.should_not include(debit_from_another_user)
		end

		it "on destroy should destroy associated debits" do
			debits = @user.debits
			@user.destroy
			debits.each do |debit|
				Debit.find_by_id(debit.id).should be_nil
			end
		end
	end
end
