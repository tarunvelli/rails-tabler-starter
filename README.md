# rails-tabler-starter

Rails starter boilerplate that you can clone and build on top off

* User authentication & authorization

    * Authentication through [Devise](https://github.com/heartcombo/devise)
    * Use [OmniAuth](https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview) to extend authentication using providers
    * Authorization thought [Pundit](https://github.com/varvet/pundit)

* Background worker & scheduler

    * Through sidekiq and sidekiq-scheduler

* Role management

    * Supports standard roles available across spaces and also custom roles per space
    * Supports fine grained permission setup

* Multi-tenant architeture

    * The `Space` model is used to represent a tenant i.e. can be a team, organization, group etc.
    * Example use case for turning on multi-tenant mode is a saas applications
    * Example use case for turning off multi-tenant mode is a internal org tools

* Pre built UI layouts

    * High quality UI elements and layouts from [Tabler](https://tabler.io/)

## Goals

Users familiar with rails should be able to build with this boilerplate without requiring extensive introduction.

* No DSL
* Avoid complex frontend functionality
* Simplicity over efficiency

## Setup

```
git clone https://github.com/tarunvelli/rails-tabler-starter.git
cd rails-tabler-starter
bundle install
yarn install
bundle exec rails db:setup
bin/dev
```

## Config

* `config.interface_layout`
    * Sets the default layout of app
    * values ["VERTICAL", "HORIZONTAL", "OVERLAP", "CONDENSED"]

* `config.interface_mode`
    * Sets the default mode of app
    * Values ["LIGHT", "DARK"]

* `config.interface_theme`
    * Sets the default color theme of app
    * Values ["DEFAULT", "COOL"]

* `config.login_layout` one of
    * Sets the default layout of login screens
    * Values ["DEFAULT", "ILLUSTRATION", "COVER"]

* `config.multi_tenant_mode`
    * When true allows users to sign up and create spaces
    * When false allows only admin to invite users and create spaces
    * Values [true, false]

* `config.show_landing_page`
    * When true root path renders landing page when user is not signed in
    * When false root path redirects to sign in page when user is not signed in
    * Values [true, false]

## Deployment

TODO: instructions to deploy on fly.io etc.

## Contribution

Contribution is welcome!