module RolesHelper
  def has?(permission)
    @role.send("can_#{permission}?")
  end
end
