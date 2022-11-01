# frozen_string_literal: true

class WelcomeController < ApplicationController
  def show
    @space = current_user.spaces.first
    if @space&.present?
      redirect_to @space
    else
      redirect_to new_space_path
    end
  end
end
