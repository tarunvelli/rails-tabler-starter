class DropColorColumnsFromUser < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :color_mode, :string
    remove_column :users, :color_scheme, :string
  end
end
