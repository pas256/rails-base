# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should load home#index as the root page' do
    get root_url
    assert_response :success
  end
end
