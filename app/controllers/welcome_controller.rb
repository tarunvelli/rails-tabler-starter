# frozen_string_literal: true

class WelcomeController < ActionController::Base
  layout 'plain'

  def index
    if current_user.nil?
      if show_landing_page?
        render 'landing/index', status: :ok
      else
        redirect_to new_user_session_path
      end
    elsif space&.present?
      redirect_to space
    else
      redirect_to new_space_path
    end
  end

  private

  def show_landing_page?
    Rails.application.config.show_landing_page
  end

  def space
    @space ||= current_user&.spaces&.filter(&:active?)&.first
  end
end
