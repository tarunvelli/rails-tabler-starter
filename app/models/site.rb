# frozen_string_literal: true

class Site < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  has_many :subscriptions, dependent: :destroy
  has_many :plans, through: :subscriptions

  has_many :roles, dependent: :destroy
  has_many :web_properties, dependent: :destroy

  validates :name, presence: true

  enum :status, { active: 0, archived: 1 }

  def all_roles
    Role.where(site_id: [nil, id])
  end

  def active_subscription
    subscriptions.active.last || Subscription.new(plan: Plan.free_plan)
  end
end
