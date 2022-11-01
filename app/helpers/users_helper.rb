module UsersHelper
  def user_name(name)
    name.blank? ? 'User' : name
  end
end
