class RenameSpacesToSites < ActiveRecord::Migration[8.1]
  def up
    rename_table :spaces, :sites

    rename_column :roles, :space_id, :site_id
    rename_column :user_roles, :space_id, :site_id
    rename_column :subscriptions, :space_id, :site_id

    rename_index :roles, :index_roles_on_space_id, :index_roles_on_site_id if index_name_exists?(:roles, :index_roles_on_space_id)
    rename_index :user_roles, :index_user_roles_on_user_id_and_space_id, :index_user_roles_on_user_id_and_site_id if index_name_exists?(:user_roles, :index_user_roles_on_user_id_and_space_id)
    rename_index :subscriptions, :index_subscriptions_on_space_id, :index_subscriptions_on_site_id if index_name_exists?(:subscriptions, :index_subscriptions_on_space_id)
  end

  def down
    rename_index :subscriptions, :index_subscriptions_on_site_id, :index_subscriptions_on_space_id if index_name_exists?(:subscriptions, :index_subscriptions_on_site_id)
    rename_index :user_roles, :index_user_roles_on_user_id_and_site_id, :index_user_roles_on_user_id_and_space_id if index_name_exists?(:user_roles, :index_user_roles_on_user_id_and_site_id)
    rename_index :roles, :index_roles_on_site_id, :index_roles_on_space_id if index_name_exists?(:roles, :index_roles_on_site_id)

    rename_column :subscriptions, :site_id, :space_id
    rename_column :user_roles, :site_id, :space_id
    rename_column :roles, :site_id, :space_id

    rename_table :sites, :spaces
  end
end
