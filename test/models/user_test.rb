# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should require a valid email' do
    # Invalid emails
    assert User.build(email: 'invalid email').invalid?
    assert User.build(email: '').invalid?
    assert User.build(email: nil).invalid?
    # assert User.build(email: 'example@example').invalid?  # TODO The regexp thinks this is valid, but is it really?

    # Valid emails
    assert User.build(email: 'example@example.com').valid?
    assert User.build(email: 'a@a.co').valid?
    assert User.build(email: 'example@really.long.domain.example.goes.here.com').valid?
    assert User.build(email: 'email.99+some.label@a.co').valid?
  end

  test 'should automatically strip spaces from email' do
    u = User.build(email: ' example@example.com')
    assert u.valid?
    assert_equal 'example@example.com', u.email

    u2 = User.build(email: 'example@example.com  ')
    assert u2.valid?
    assert_equal 'example@example.com', u2.email
  end

  test 'should lowercase emails before validating' do
    u = User.build(email: ' Example@MY.EXAMPLE1.com')
    assert u.valid?
    assert_equal 'example@my.example1.com', u.email
  end

  test 'should require emails to be unique' do
    User.create(email: 'uniq@example.com')
    u = User.build(email: 'UniQ@ExamplE.com')
    assert u.invalid?
    assert u.errors[:email].include?('has already been taken')
  end
end
