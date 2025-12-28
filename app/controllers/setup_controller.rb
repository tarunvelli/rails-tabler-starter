class SetupController < ApplicationController
  include SettingsHelper

  def edit
    @app_setting = AppSettings.first_or_initialize
  end

  def update
    @app_setting = AppSettings.first_or_initialize

    respond_to do |format|
      if @app_setting.update(settings: setup_params)
        format.html { redirect_to edit_setup_path, notice: "Settings were successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def setup_params
    allowed_keys = Rails.application.config.app_settings.keys
    params.require(:app_settings).permit(settings: allowed_keys)[:settings]
  end
end
