# frozen_string_literal: true

module UsersHelper
  def user_name(name)
    name.blank? ? 'User' : name
  end
end
