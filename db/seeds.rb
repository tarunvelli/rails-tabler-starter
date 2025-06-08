# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Role.create!(
  [
    {
      name: 'Editor',
      value: 'EDITOR',
      type: 'common',
      permissions: {
        'read_user' => 'true',
        'read_space' => 'true',
        'create_user' => 'true',
        'delete_user' => 'true',
        'update_user' => 'true',
        'create_space' => 'true',
        'delete_space' => 'true',
        'update_space' => 'true'
      }
    },
    {
      name: 'Viewer',
      value: 'VIEWER',
      type: 'common',
      permissions: {
        'read_user' => 'true',
        'read_space' => 'true',
        'create_user' => 'false',
        'delete_user' => 'false',
        'update_user' => 'false',
        'create_space' => 'false',
        'delete_space' => 'false',
        'update_space' => 'false'
      }
    }
  ]
)

DefaultAppSettings = Rails.application.config.app_settings.map do |key, data|
  {
    key: key,
    value: data['default']
  }
end

AppSettings.create!(DefaultAppSettings)

Plan.create!([
  {
    name: 'Free',
    price: 0,
    currency: 'USD',
    description: {
      features: 'all'
    },
    duration: '1Y'
  },
  {
    name: 'Premium',
    price: 9,
    currency: 'USD',
    description: {
      features: 'all'
    },
    duration: '1Y'
  },
  {
    name: 'Enterprise',
    price: 19,
    currency: 'USD',
    description: {
      features: 'all'
    },
    duration: '1Y'
  },
  {
    name: 'Unlimited',
    price: 29,
    currency: 'USD',
    description: {
      features: 'all'
    },
    duration: '1Y'
  }
])
