# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :status, :integer, default: 0
    add_column :users, :session_token, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :color_scheme, :string
    add_column :users, :color_mode, :string
  end
end
