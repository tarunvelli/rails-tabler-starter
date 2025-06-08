# frozen_string_literal: true

class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :value
      t.string :type
      t.json :permissions, null: false, default: '{}'
      t.references :space, null: true, foreign_key: true

      t.timestamps
    end
  end
end
