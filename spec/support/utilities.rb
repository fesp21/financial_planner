RSpec::Matchers.define :have_title do |text|
	match do |page|
		page.should have_selector('title', text: text)
	end
end

RSpec::Matchers.define :have_h1 do |text|
	match do |page|
		page.should have_selector('h1', text: text)
	end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_validation_error do |message|
  match do |page|
    page.should have_selector('div#error_explanation ul li', text: message)
  end
end

def sign_in(user)
  visit signin_path
  valid_sign_in(user)
end

def valid_sign_in(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end
