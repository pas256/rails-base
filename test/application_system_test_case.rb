# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionMailer::TestHelper

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  # I18n helper that for some reason is not Rails by default
  def t(id, *)
    c = self.class.to_s.delete_suffix('Test').downcase
    I18n.translate!("#{c}.#{id}", *)
  end
end
