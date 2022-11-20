class AddPalleteToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pallete, :string
  end
end
