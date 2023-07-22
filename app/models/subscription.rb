# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  end_date   :datetime
#  seats      :integer
#  start_date :datetime         not null
#  plan_id    :bigint           not null
#  space_id   :bigint           not null
#
class Subscription < ApplicationRecord
  belongs_to :space
  belongs_to :plan
end
