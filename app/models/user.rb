# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_roles
  has_many :spaces, through: :user_roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :confirmable

  enum status: %i[active archived]

  def name
    "#{first_name} #{last_name}"
  end

  def authenticatable_salt
    "#{super}#{session_token}"
  end

  def invalidate_all_sessions!
    update_attribute(:session_token, SecureRandom.hex)
  end

  def get_role_in_space(space)
    user_roles.find_by(space: space).role
  end
end
