require 'spec_helper'

describe "Category views" do

	subject { page }

	describe "new" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit new_category_path
		end

		it { should have_selector('h1', text: 'Add Category') }
		it { should have_selector('title', text: 'Add Category') }

		describe "adding new category" do
			describe "with no information" do
				it "should not create a category" do
					expect { click_button "Add Category" }.not_to change(Category, :count)
				end

				describe "error messages" do
					before { click_button "Add Category" }

					it { should have_h1('Add Category') }
					it { should have_title('Add Category') }
					it { should have_validation_error("Name can't be blank") }
					it { should have_validation_error("Budget can't be blank") }
				end
			end

			describe "with wrong information" do
				describe "name too long" do
					before do
						fill_in "Name", with: "a"*51
						click_button "Add Category"
					end

					it { should have_validation_error("Name is too long (maximum is 50 characters)") }
				end

				describe "budget is zero" do
					before do
						fill_in "Budget", with: "0"
						click_button "Add Category"
					end

					it { should have_validation_error("Budget can't be negative or zero") }
				end

				describe "budget not a number" do
					before do
						fill_in "Budget", with: "not money"
						click_button "Add Category"
					end

					it { should have_validation_error("Budget is not a number") }
				end

				describe "budget has fractions of a cent" do
					before do
						fill_in "Budget", with: "1.234"
						click_button "Add Category"
					end

					it { should have_validation_error("Budget can't have fractions of a cent") }
				end
			end

			describe "with valid information" do
				before do
					fill_in "Name", with: "Cats"
					fill_in "Budget", with: "150.00"
				end

				it "should create a category" do
					expect do
						click_button "Add Category"
					end.to change(Category, :count).by(1)
				end

				describe "after saving the category" do
					before { click_button "Add Category" }

					it { should have_success_message("Category successfully added.") }
					it { should have_title("Add Category") }

					describe "and adding invalid category" do
						before { click_button "Add Category" }

						it { should_not have_success_message("Category successfully added.") }
					end
				end
			end
		end
	end
end
