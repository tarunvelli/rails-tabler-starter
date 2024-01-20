class SetupController < ApplicationController
  include SettingsHelper

  def edit
    @app_settings = AppSettings.where(key: Rails.application.config.app_settings.keys).order(:key)
  end

  def update
    app_settings = params["app_settings"]

    respond_to do |format|
      if AppSettings.update(app_settings.keys, app_settings.values)
        format.html { redirect_to edit_setup_path, notice: "Settings were successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
end
