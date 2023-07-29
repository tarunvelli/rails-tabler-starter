# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SettingsHelper
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
