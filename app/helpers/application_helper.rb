# frozen_string_literal: true

# Custom helper methods used (mostly) in views
module ApplicationHelper
  def form_error_notification(object)
    return unless object.errors.any?

    tag.div class: 'error-message text-red-600 dark:text-red-400' do
      object.errors.full_messages.to_sentence.capitalize
    end
  end
end
