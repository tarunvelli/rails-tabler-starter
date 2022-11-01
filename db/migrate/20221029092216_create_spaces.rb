# frozen_string_literal: true

class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :status
      t.text :address

      t.timestamps
    end
  end
end
