module RolesHelper
  def has_access?(object, access)
    @role.permissions[object] == access
  end
end
