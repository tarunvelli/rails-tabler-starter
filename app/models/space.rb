# frozen_string_literal: true

# == Schema Information
#
# Table name: spaces
#
#  id         :bigint           not null, primary key
#  name       :string
#  phone      :string
#  email      :string
#  status     :integer
#  address    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Space < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  has_many :subscriptions
  has_many :plans, through: :subscriptions

  validates :name, presence: true

  enum status: %i[active archived]

  def all_roles
    Role.where(space_id: [nil, id])
  end
end
