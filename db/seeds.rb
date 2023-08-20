# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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

AppSettings.create!(
  [
    {
      key: 'interface_layout',
      value: 'HORIZONTAL'
    },
    {
      key: 'interface_mode',
      value: 'LIGHT'
    },
    {
      key: 'interface_theme',
      value: 'DEFAULT'
    },
    {
      key: 'login_layout',
      value: 'DEFAULT'
    },
    {
      key: 'multi_space_mode',
      value: 'true'
    },
    {
      key: 'show_landing_page',
      value: 'true'
    }
  ]
)

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