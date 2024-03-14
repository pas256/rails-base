# frozen_string_literal: true

require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  test 'Sign up a new user' do
    visit root_path
    assert_selector 'div', text: I18n.t('sessions.sign_in')
    click_on t('.sign_in')

    # Confirm error messages are displayed
    fill_in 'session_email', with: 'invalid'
    click_on t('new.submit')
    error_message = page.find_by_id('session_email').native.attribute('validationMessage')
    assert_equal "Please include an '@' in the email address. 'invalid' is missing an '@'.", error_message

    # Create the new user
    fill_in 'session_email', with: 'new@user.com'
    assert_emails 1 do
      click_on t('new.submit')
      assert_text t('email.title')
    end
  end
end
