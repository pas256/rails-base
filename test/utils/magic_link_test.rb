# frozen_string_literal: true

require 'test_helper'

class MagicLinkTest < ActiveSupport::TestCase
  test 'should produce a magic-link string' do
    email = 'example@email.com'
    token = MagicLink.generate_token(email)
    assert token
    assert token.length > 10
  end

  test 'should decode the token' do
    email = 'example2@email.com'
    token = MagicLink.generate_token(email)
    assert_equal email, MagicLink.verify_token(token)
  end

  test 'should fail verification after 1 hour' do
    email = 'example3@email.com'
    token = MagicLink.generate_token(email)
    travel 61.minutes do
      assert_nil MagicLink.verify_token(token)
    end
  end

  test 'should fail verification after being used only once' do
    email = 'example4@email.com'
    token = MagicLink.generate_token(email)
    assert_equal email, MagicLink.verify_token(token)
    assert_nil MagicLink.verify_token(token)
  end

  test 'should clean the email in the token' do
    token = MagicLink.generate_token('  MyCRAPPY+email@EXAMPLE.domain.email.com      ')
    assert_equal 'mycrappy+email@example.domain.email.com', MagicLink.verify_token(token)
  end
end
