# frozen_string_literal: true

# Handles user authentication session management
class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:test]
  before_action :set_new_user, only: [:create]

  def new
    @user = User.new
  end

  def create
    # Validate email address
    return render :new, status: :unprocessable_entity unless @user.valid?

    # Send magic link email
    magic_link_url = sessions_verify_url(token: MagicLink.generate_token(@user.email))
    UserMailer.with(email: @user.email, url: magic_link_url).magic_link_email.deliver_later
    session[:unverified_email] = session_params[:email]
    redirect_to sessions_email_path
  end

  def email
    redirect_to root_url if user_signed_in?
    @unverified_email = session[:unverified_email]
  end

  def verify # rubocop:disable Metrics/AbcSize
    email = MagicLink.verify_token(params[:token])
    if email
      user = User.find_or_create_by(email:)
      sign_in_user(user.id)
      flash[:notice] = t('.signed_in_as', email: user.email)
      redirect_to root_url
    else
      flash[:error] = t('.invalid_magic_link')
      redirect_to sessions_new_path
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def test
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email)
  end

  def set_new_user
    @user = User.build(session_params)
  end
end
