# frozen_string_literal: true

# == Schema Information
#
# Table name: user_roles
#
#  id       :bigint           not null, primary key
#  role_id  :bigint           not null
#  space_id :bigint           not null
#  user_id  :bigint           not null
#
class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :site
  belongs_to :role

  validate :role_belongs_to_site

  private

  def role_belongs_to_site
    return if role.common?
    return if role.site == site

    errors.add(:base, "invalid role for site")
  end
end
