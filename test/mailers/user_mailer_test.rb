# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'the magic link email should have fields filled in' do
    email_address = users(:one).email
    url = 'https://example.com/magic_link'
    email = UserMailer.magic_link_email(email_address, url)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['notifications@example.com'], email.from
    assert_equal [email_address], email.to
    assert_equal 'Magic link email', email.subject

    # For plain text, test the entire body
    assert_equal read_fixture('magic_link.text').join, email.text_part.body.to_s

    # For HTML, make sure it is rendered with MJML correctly and variables are substituted
    html_body = email.html_part.body.to_s
    assert_not_includes html_body, 'mjml', 'MJML should be rendered to HTML'
    assert_includes html_body, '<html lang="en"'
    assert_includes html_body, '<body style="'
    assert_includes html_body, 'Click the magic link to sign in' # preview text
    assert_includes html_body, url
    assert_includes html_body, "This message was sent to #{email_address}.<br />"
  end
end
