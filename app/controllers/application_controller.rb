# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_layout
  before_action :set_mode
  before_action :set_theme

  def set_layout
    @layout = params[:layout]
  end

  def set_mode
    @mode = params[:mode]
  end

  def set_theme
    @theme = params[:theme]
  end
end
