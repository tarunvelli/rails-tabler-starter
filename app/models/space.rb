# frozen_string_literal: true

class Space < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, presence: true

  enum status: %i[active archived]

  def all_roles
    Role.where(space_id: [nil, id])
  end
end
