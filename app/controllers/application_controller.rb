# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!
  before_action :set_layout
  before_action :set_mode
  before_action :set_theme

  private

  def set_layout
    @layout = params[:layout]
  end

  def set_mode
    @mode = params[:mode] || current_user&.pallete&.split('-')&.dig(0)
  end

  def set_theme
    @theme = params[:theme] || current_user&.pallete&.split('-')&.dig(1)
  end

  def multi_tenant_mode?
    Rails.application.config.multi_tenant_mode || current_user&.admin?
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
