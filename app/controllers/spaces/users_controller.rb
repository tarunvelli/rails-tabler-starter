# frozen_string_literal: true

class Spaces::UsersController < ApplicationController
  before_action :set_space, only: %i[index new create edit update destroy]
  before_action :set_user, only: %i[edit update destroy]
  before_action :set_user_role, only: %i[edit update destroy]

  # GET /spaces/:space_id/users
  def index
    @users = @space.users
  end

  def new
    @space_roles = @space.all_roles
  end

  def create
    user = User.find_by(email: params[:email]) || User.invite!(email: params[:email])
    user_role = UserRole.find_by(space: @space, user: user)

    respond_to do |format|
      if !user_role.present? && UserRole.create(user_id: user.id, space_id: params[:space_id], role_id: params[:role_id])
        format.html { redirect_to space_users_path(@space), notice: 'User was successfully invited.' }
        format.json { render :index, status: :ok }
      else
        format.html { redirect_to space_users_path(@space) }
        format.json { render json: ['Failed to invite user'], status: :unprocessable_entity }
      end
    end
  end

  def edit
    @space_roles = @space.all_roles
  end

  def update
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

  def destroy
    respond_to do |format|
      if @user_role.delete
        format.html { redirect_to space_users_path(@space), notice: 'User role was successfully removed.' }
        format.json { render :index, status: :ok }
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
