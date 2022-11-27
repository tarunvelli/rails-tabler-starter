# frozen_string_literal: true

class Spaces::UsersController < ApplicationController
  before_action :set_space, only: %i[index]

  # GET /spaces/:space_id/users
  def index
    @users = @space.users
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:space_id])
  end
end
