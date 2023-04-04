# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  end_date   :datetime         not null
#  start_date :datetime         not null
#  plan_id    :bigint           not null
#  space_id   :bigint           not null
#
class Subscription < ApplicationRecord
  belongs_to :space
  belongs_to :plan
end
