class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.string :crm_id
      t.float :price, null: false
      t.string :currency, null: false
      t.json :description
      t.string :duration, null: false

      t.timestamps
    end
  end
end
