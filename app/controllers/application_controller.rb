# frozen_string_literal: true

# Base level controller for everything
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def sign_in_user(user_id)
    # Issue a new session identifier after successful login
    # See: https://guides.rubyonrails.org/security.html#session-fixation-countermeasures
    reset_session

    session[:user_id] = user_id
    extend_session
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user!
    if session[:valid_until].present? && (session[:valid_until] > Time.now.utc.to_i) && current_user
      extend_session
      return
    end

    # Expired or invalid session
    reset_session # TODO: Figure out if I want to do this or not - its a security meausre
    redirect_to sessions_new_path
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def extend_session
    session[:valid_until] = 30.days.from_now.utc.to_i
  end
end
