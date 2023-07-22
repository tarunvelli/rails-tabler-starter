class RemoveActiveColumnFromSubscription < ActiveRecord::Migration[7.0]
  def change
    remove_column :subscriptions, :active, :integer
  end
end
