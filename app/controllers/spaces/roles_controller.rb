# frozen_string_literal: true

class Spaces::RolesController < ApplicationController
  before_action :set_role, only: %i[show edit update destroy]
  before_action :set_space, only: %i[index edit update new create]

  # GET /roles or /roles.json
  def index
    @space_roles = @space.all_roles.page params[:page]
  end

  # GET /spaces/:space_id/roles1 or /spaces/:space_id/roles1.json
  def show; end

  # GET /spaces/:space_id/rolesnew
  def new
    @role = Role.new
  end

  # GET /spaces/:space_id/roles1/edit
  def edit; end

  # POST /roles or /roles.json
  def create
    @role = Roles::Custom.new(create_role_params)
    @role.site = @space

    respond_to do |format|
      if @role.save
        format.html { redirect_to edit_space_role_path(@space, @role), notice: "role was successfully created." }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/:space_id/roles1 or /spaces/:space_id/roles1.json
  def update
    respond_to do |format|
      if @role.update(update_role_params)
        format.html { redirect_to edit_space_role_path(@space, @role), notice: "role was successfully updated." }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/:space_id/roles1 or /spaces/:space_id/roles1.json
  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to roles_url, notice: "role was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def create_role_params
    params.require(:role).permit(:name, :value, permissions: {})
  end

  def update_role_params
    params.require(:role).permit(:name, permissions: {})
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end
