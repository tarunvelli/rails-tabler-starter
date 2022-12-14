# rails-tabler-starter

Rails starter boilerplate that you can clone and build on top of

* User authentication & authorization

    * Authentication through [Devise](https://github.com/heartcombo/devise)
    * Use [OmniAuth](https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview) to extend authentication using providers
    * Authorization thought [Pundit](https://github.com/varvet/pundit)

* Background worker & scheduler

    * Using sidekiq and sidekiq-scheduler

* Role management

    * Supports standard roles available across spaces and also creating custom roles per space
    * Supports fine grained permissions per role

* Multi-tenant architeture

    * The `Space` model is used to represent a tenant i.e. can be a team, organization, group etc.
    * Example use case for turning on multi-tenant mode is a saas application
    * Example use case for turning off multi-tenant mode is an internal org tool

* Pre built UI layouts

    * High quality UI elements and layouts from [Tabler](https://tabler.io/)

* Development focussed

    * [Annotate](https://github.com/ctran/annotate_models) - Annotate Rails classes with schema and routes info
    * [Brakeman](https://github.com/presidentbeef/brakeman) - A static analysis security vulnerability scanner
    * [Byebug](https://github.com/deivid-rodriguez/byebug) - Simple debugger
    * [Dotenv](https://github.com/bkeepers/dotenv) - Load environment variables from `.env`

## Goals

Users familiar with rails should be able to build with this boilerplate without requiring extensive introduction.

* No DSL
* Avoid complex frontend functionality
* Simplicity over efficiency

## Setup

requires postgres and redis to run on local

```
brew install postgresql@12 redis
```

clone and run the app

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
    * "SYSTEM" picks the mode from system preferences
    * Values ["LIGHT", "DARK", "SYSTEM"]

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