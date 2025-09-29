class SetupController < ApplicationController
  include SettingsHelper

  def edit
    @app_settings = AppSettings.where(key: Rails.application.config.app_settings.keys).order(:key)
  end

  def update
    respond_to do |format|
      if AppSettings.update(keys, values)
        format.html { redirect_to edit_setup_path, notice: "Settings were successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def setup_params
    params.require(:app_settings).permit!
  end

  def keys
    setup_params.keys
  end

  def values
    setup_params.values.map(&:to_h)
  end
end
