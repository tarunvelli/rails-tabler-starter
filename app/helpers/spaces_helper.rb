module SpacesHelper
  def common_roles
    @common_roles ||= Roles::Common.all
  end

  def custom_roles
    @custom_roles ||= Roles::Custom.where(space: @space)
  end

  def space_roles
    @space_roles ||= common_roles + custom_roles
  end
end
