require 'spec_helper'

describe "Debit views" do

	subject { page }

	describe "new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_debit_path
		end

		it { should have_h1('Add Debit') }
		it { should have_title('Add Debit') }

		describe "adding new debit" do
			describe "with no information" do
				it "should not create a debit" do
					expect { click_button "Add Debit" }.not_to change(Debit, :count)
				end

				describe "error messages" do
					before { click_button "Add Debit" }

					it { should have_h1('Add Debit') }
					it { should have_title('Add Debit') }
					it { should have_validation_error("Cost can't be blank") }
					it { should have_validation_error("Transaction date can't be blank") }
				end
			end

			describe "with invalid information" do
				describe "cost is zero" do
					before do
						fill_in "Cost", with: "0"
						click_button "Add Debit"
					end

					it { should have_validation_error("Cost can't be negative or zero") }
				end

				describe "cost is not a number" do
					before do
						fill_in "Cost", with: "not money"
						click_button "Add Debit"
					end

					it { should have_validation_error("Cost is not a number") }
				end

				describe "cost has fractions of a cent" do
					before do
						fill_in "Cost", with: "1.234"
						click_button "Add Debit"
					end

					it { should have_validation_error("Cost can't have fractions of a cent") }
				end

				describe "transaction date is not a date" do
					before do
						fill_in "Transaction date", with: "not a date"
						click_button "Add Debit"
					end

					it { should have_validation_error("Transaction date is not a date") }
				end
			end

			describe "with valid information" do
				before do
					fill_in "Cost", with: "150.00"
					fill_in "Transaction date", with: "Jan 1, 2012"
				end

				it "should create a debit" do
					expect do
						click_button "Add Debit"
					end.to change(Debit, :count).by(1)
				end

				describe "after saving the debit" do
					before { click_button "Add Debit" }

					it { should have_success_message("Debit deducted. *flush*") }
					it { should have_title("Add Debit") }

					describe "and adding invalid debit" do
						before { click_button "Add Debit" }

						it { should_not have_success_message("Debit deducted. *flush*") }
					end
				end
			end
		end
	end
end