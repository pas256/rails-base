# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new session' do
    get sessions_new_url
    assert_response :success
    assert_not_nil assigns(:user)
    assert_nil session[:user_id]
  end

  test 'should show an error for an invalid email' do
    post sessions_create_url, params: { session: { email: 'invalid' } }
    assert_response :unprocessable_entity
    assert_equal 'create', @controller.action_name
  end

  test 'should send a magic link email and show instructions' do
    email = 'test1@example.com'
    assert_emails 1 do
      post sessions_create_url, params: { session: { email: } }
    end
    assert_redirected_to sessions_email_path
    assert_equal email, session[:unverified_email]
  end

  test 'should skip verification if already signed in' do
    sign_in_as(users(:one).email)
    get sessions_email_url
    assert_redirected_to root_url
  end

  test 'should redirect to session new for invalid magic link token' do
    get sessions_verify_url(token: 'invalid')
    assert_redirected_to sessions_new_path
    assert_equal 'Invalid or expired magic link', flash[:error]
  end

  test 'should sign in a new user' do
    email = 'email1@examplez.com'
    token = MagicLink.generate_token(email)
    assert_difference('User.count') do
      get sessions_verify_url(token:)
    end
    assert_redirected_to root_path
    assert_equal User.find_by(email:).id, session[:user_id]
    assert_equal "Signed in as #{email}", flash[:notice]
  end

  test 'should sign in an existing user' do
    user = users(:one)
    email = user.email
    token = MagicLink.generate_token(email)
    assert_no_difference('User.count') do
      get sessions_verify_url(token:)
    end
    assert_redirected_to root_path
    assert_equal user.id, session[:user_id]
    assert_operator 29.days.from_now.utc.to_i, :<, session[:valid_until]
    assert_equal "Signed in as #{email}", flash[:notice]
  end

  test 'should destroy the session' do
    user = users(:one)
    sign_in_as(user.email)
    assert_equal user.id, session[:user_id]

    get sessions_destroy_url
    assert_redirected_to root_url
    assert_nil session[:user_id]
    assert_nil session[:valid_until]
  end

  test 'should sign out a user with an expired session' do
    user = users(:one)
    sign_in_as(user.email)
    assert_equal user.id, session[:user_id]

    get sessions_new_url
    assert_response :success
    assert_equal user.id, session[:user_id]

    travel_to 31.days.from_now do
      get sessions_test_path
      assert_redirected_to sessions_new_url
      assert_nil session[:user_id]
      assert_nil session[:valid_until]
    end
  end
end
