# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :set_role, only: %i[show edit update destroy]
  before_action :set_space, only: %i[index edit update new]

  # GET /roles or /roles.json
  def index
    @common_roles = Roles::Common.all
    @custom_roles = Roles::Custom.where(space: @space)
    @space_roles = @common_roles + @custom_roles
  end

  # GET /roles/1 or /roles/1.json
  def show; end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit; end

  # POST /roles or /roles.json
  def create
    @role = role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to role_url(@role), notice: 'role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1 or /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to edit_space_role_path(@space, @role), notice: 'role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1 or /roles/1.json
  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:name, :value, permissions: [:user, :space])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:space_id])
  end
end
