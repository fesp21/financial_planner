require 'spec_helper'

describe "Authentication" do
  
  subject { page }

  describe "signin page" do
  	before { visit signin_path }

  	it { should have_selector('h1', text: 'Sign In') }
  	it { should have_selector('title', text: 'Sign In') }
  end

  describe "signin" do
  	before { visit signin_path }

  	describe "with invalid information" do
  		before { click_button "Sign In" }

  		it { should have_selector('title', text: 'Sign In') }
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }

  		describe "after visiting another page" do
  			before { visit root_path }

  			it { should_not have_selector('div.alert.alert-error', text: 'Invalid') }
  		end
  	end

  	describe "with valid information" do
  		let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it { should have_selector('p', text: 'woooo congrats you\'re an admin') }

      describe "followed by signout" do
      	before { click_link "Sign out" }
      	it { should have_selector('p', text: 'another onessss') }
      end
    end
  end
end
