# frozen_string_literal: true

class Spaces::UsersController < ApplicationController
  before_action :set_space, only: %i[index edit user_role]
  before_action :set_user, only: %i[edit user_role]
  before_action :set_user_role, only: %i[edit user_role]

  # GET /spaces/:space_id/users
  def index
    @users = @space.users
  end

  def edit; end

  def user_role
    respond_to do |format|
      if @user_role.update(user_role_params)
        format.html { redirect_to edit_space_user_path(@space, @user), notice: 'User role was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_role_params
    params.require(:user_role).permit(:role_id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:space_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_role
    @user_role = UserRole.find_by(space: @space, user: @user)
  end
end
