module UsersHelper
  def user_name(name)
    name.blank? ? 'User' : name
  end

  def abbrev_name(name)
    name.split(' ').map(&:first).join('.')
  end
end
