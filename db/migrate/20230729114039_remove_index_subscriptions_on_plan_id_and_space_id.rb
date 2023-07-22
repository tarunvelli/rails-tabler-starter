class RemoveIndexSubscriptionsOnPlanIdAndSpaceId < ActiveRecord::Migration[7.0]
  def change
    remove_index :subscriptions, [:plan_id, :space_id], unique: true, name: "index_subscriptions_on_plan_id_and_space_id"
  end
end
