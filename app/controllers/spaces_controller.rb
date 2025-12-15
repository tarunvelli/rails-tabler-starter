# frozen_string_literal: true

class SpacesController < ApplicationController
  before_action :set_space, only: %i[ show edit update destroy ]
  before_action :check_multi_tenant_mode, only: %i[new index]

  def index
    @spaces = current_user.spaces.page params[:page]
  end

  # GET /spaces/1
  def show; end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit; end

  # POST /spaces
  def create
    @space = Space.new(space_params)
    @space.users.push(current_user)
    @space.user_roles.each { |user_role| user_role.role = Role.first }

    if @space.save
      redirect_to space_url(@space), notice: "Space was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /spaces/1
  def update
    if @space.update(space_params)
      flash.now[:notice] = "Space was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /spaces/1
  def destroy
    @space.destroy!

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Space was successfully destroyed." }
      format.html { redirect_to spaces_path, notice: "Space was successfully destroyed.", status: :see_other }
    end
  end

  private
    def set_space
      @space = Space.find(params.expect(:id))
    end

    def space_params
      params.expect(space: [ :name, :status ])
    end

    def check_multi_tenant_mode
      return if multi_tenant_mode? || current_user&.admin?

      redirect_back fallback_location: root_path
    end
end
