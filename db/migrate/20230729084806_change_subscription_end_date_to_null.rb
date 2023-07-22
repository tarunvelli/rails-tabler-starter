class ChangeSubscriptionEndDateToNull < ActiveRecord::Migration[7.0]
  def change
    change_column :subscriptions, :end_date, :datetime, null: true
  end
end
