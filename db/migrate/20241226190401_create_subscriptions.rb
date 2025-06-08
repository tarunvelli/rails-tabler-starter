class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :plan, null: false
      t.references :space, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: true
      t.integer :seats
    end
  end
end
