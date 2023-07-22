class AddSeatsToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :seats, :integer
  end
end
