class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :plan, null: false
      t.references :space, null: false
      t.boolean :active, default:true, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
    end

    add_index :subscriptions, [:plan_id, :space_id], unique: true
  end
end
