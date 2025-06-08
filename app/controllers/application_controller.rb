class ApplicationController < ActionController::Base
  include SettingsHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!, except: [ :landing ]
  before_action :set_main_space, only: [ :landing ]
  before_action :redirect_signed_in_user, only: [ :landing ]

  layout "plain", only: [ :landing ]

  def landing; end

  private

  def redirect_signed_in_user
    return unless user_signed_in?

    redirect_to @main_space ? space_path(@main_space) : spaces_path
  end

  def set_main_space
    @main_space = current_user&.spaces&.first
  end
end
