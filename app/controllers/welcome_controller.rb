# frozen_string_literal: true

class WelcomeController < ActionController::Base
  include ConfigHelper

  layout 'plain'
  before_action :check_signed_in, only: [:index]

  def index
    if show_landing_page?
      redirect_to about_path
    else
      redirect_to new_user_session_path
    end
  end

  def about
    render 'about', status: :ok, cached: true
  end

  private

  def space
    @space ||= current_user&.spaces&.filter(&:active?)&.first
  end

  def check_signed_in
    return if current_user.nil?

    if space&.present?
      redirect_to space
    else
      redirect_to new_space_path
    end
  end
end
