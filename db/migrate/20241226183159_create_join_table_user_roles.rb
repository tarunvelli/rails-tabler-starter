# frozen_string_literal: true

class CreateJoinTableUserRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_roles do |t|
      t.references :user, index: false, null: false
      t.references :space, index: false, null: false
      t.references :role, index: false, null: false
    end

    add_index :user_roles, [ :user_id, :space_id ], unique: true
  end
end
