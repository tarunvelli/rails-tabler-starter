class ConvertAppSettingsToJsonb < ActiveRecord::Migration[8.1]
  def up
    remove_column :app_settings, :key, :string
    remove_column :app_settings, :value, :string

    add_column :app_settings, :settings, :jsonb, default: {}, null: false

    add_index :app_settings, :settings, using: :gin
  end

  def down
    execute("DELETE FROM app_settings")
    remove_column :app_settings, :settings

    add_column :app_settings, :key, :string, null: false
    add_column :app_settings, :value, :string, null: false

    add_index :app_settings, :key, unique: true
  end
end
