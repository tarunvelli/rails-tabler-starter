# == Schema Information
#
# Table name: plans
#
#  id          :bigint           not null, primary key
#  currency    :string           not null
#  description :jsonb
#  duration    :string           not null
#  name        :string           not null
#  price       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  crm_id      :string
#
class Plan < ApplicationRecord
  has_many :subscriptions
  has_many :spaces, through: :subscriptions
end
