module SupportCode

  def sign_in(user)
    visit signin_path
    fill_in "session_email",    with:user.email
    fill_in "session_password", with:user.password
    click_button "Sign in"
    # Sign in when not using Capybara as well.
    cookies[:remember_token] = user.remember_token
  end

  def valid_sign_in(user)
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Sign in"
  end

  def create_new_user
    fill_in "Name",         with: "Example User"
    fill_in "Email",        with: "user@example.com"
    fill_in "Password",     with: "foobar"
    fill_in "Confirmation", with: "foobar"
  end

  RSpec::Matchers.define :have_error_message do|message|
    match do |page|
      page.should have_selector('div.alert.alert-error', text: message)
    end
  end

  RSpec::Matchers.define :have_message do|message|
    match do |page|
      page.should have_selector('div.alert.alert-success', text: message)
    end
  end

  RSpec::Matchers.define :have_error_div do|message|
    match do |page|
      page.should have_selector('div.alert.alert-error')
    end
  end
end