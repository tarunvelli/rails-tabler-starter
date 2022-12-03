# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @space = current_user.spaces.filter(&:active?).first
    if @space&.present?
      redirect_to @space
    else
      redirect_to new_space_path
    end
  end
end