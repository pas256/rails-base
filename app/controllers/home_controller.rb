# frozen_string_literal: true

# Controller for home page
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  # GET /
  def index; end
end
