# frozen_string_literal: true

module UsersHelper
  def user_name(name)
    (name.presence || "User")
  end
end
