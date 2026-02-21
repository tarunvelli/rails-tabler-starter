# frozen_string_literal: true

class AddPerformanceIndexes < ActiveRecord::Migration[8.1]
  def change
    add_index :user_roles, :role_id
    add_index :subscriptions, :end_date
  end
end
