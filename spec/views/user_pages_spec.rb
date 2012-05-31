require 'spec_helper'

describe "User views" do

	subject { page }

	describe "sign up page" do
		before { visit new_user_path }

		it { should have_selector('h1', text: 'Add User') }
		it { should have_selector('title', text: 'Add User') }

		describe "signing up" do
	    describe "with invalid information" do
	      it "should not create a user" do
	        expect { click_button "Create my account" }.not_to change(User, :count)
	      end

	      describe "error messages" do
	        before { click_button "Create my account" }

	        it { should have_selector('title', text: 'Add User') }
	        it { should have_content("Password can't be blank") }
	        it { should have_content("Name can't be blank") }
	        it { should have_content("Email can't be blank") }
	        it { should have_content("Email is invalid") }
	        it { should have_content("Password is too short (minimum is 6 characters)") }
	        it { should have_content("Password confirmation can't be blank") }
	      end
	    end

	    describe "with valid information" do
	      before do
	      	let(:user) { FactoryGirl.create(:user) }
	        fill_in "Name",         with: user.name
	        fill_in "Email",        with: user.email
	        fill_in "Password",     with: user.password
	        fill_in "Confirmation", with: user.password_confirmation
	      end

	      it "should create a user" do
	        expect do
	          click_button "Create my account"
	        end.to change(User, :count).by(1)
	      end

	      describe "after saving the user" do
	        before { click_button "Create my account" }

	        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
	        it { should have_link('Sign out') }
	      end
	    end
	  end
  end
end
