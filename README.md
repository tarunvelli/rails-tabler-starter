<p align="center">
    <img src="https://repository-images.githubusercontent.com/575705097/fef162b3-b1f8-417b-a62a-1ee817c96b97" alt="Banner" style="width: 100%; max-width: 800px;" />
</p>

<p align="center">
    <a href="https://github.com/tarunvelli/rails-tabler-starter/blob/main/LICENSE.md"><img alt="Github license" src="https://img.shields.io/badge/License-MIT-blue.svg"></a>
    <a href="https://rubyonrails.org/"><img alt="Rails v7.0.x" src="https://img.shields.io/badge/Rails-v7.0.x-FF2D20?logo=ruby-on-rails"></a>
    <a href="https://www.ruby-lang.org/en/"><img alt="Ruby 3.1.2" src="https://img.shields.io/badge/Ruby-3.1.2-FF2D20?logo=ruby"></a>
</p>

# Rails Tabler Starter

Rails starter boilerplate that you can clone and build on top of

[Click here](https://rails-tabler.fly.dev) to view demo application. Check out the [Demo setup page](https://rails-tabler.fly.dev/setup/edit) to toggle application settings.

## Overview

* User authentication & authorization

    * Authentication through [Devise](https://github.com/heartcombo/devise)
    * Use [OmniAuth](https://github.com/heartcombo/devise/wiki/OmniAuth%3A-Overview) to extend authentication using providers
    * Authorization thought [Pundit](https://github.com/varvet/pundit)

* Background worker & scheduler

    * Using [sidekiq](https://github.com/mperham/sidekiq/) and [sidekiq-scheduler](https://github.com/sidekiq-scheduler/sidekiq-scheduler)

* Role management

    * Supports standard roles available across spaces and also creating custom roles per space
    * Supports fine grained permissions per role

* Multiple user groups support

    * The `Space` model is used to represent a group i.e. can be a team, organization, group etc.
    * Example use case for turning on multi-space mode is a saas application
    * Example use case for turning off multi-space mode is an internal org tool

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

clone the repo

```
git clone https://github.com/tarunvelli/rails-tabler-starter.git
```

use asdf to install required dependencies, or setup the dependencies `.tool-versions` in another way
```
asdf install
```

setup and run dev server
```
bin/setup
bin/dev
```

Mark a user as admin from console to view admin features in the user dropdown
```
bundle exec rails c
> User.first.update(admin: true)
```

## AppSettings

Toggle app settings at `/setup/edit`

* `AppSettings.interface_layout`
    * Layout of app
    * values ["VERTICAL", "HORIZONTAL", "OVERLAP", "CONDENSED"]

* `AppSettings.interface_mode`
    * Light/Dark mode of app
    * "SYSTEM" picks the mode from system preferences
    * Values ["LIGHT", "DARK", "SYSTEM"]

* `AppSettings.interface_theme`
    * Color theme of app
    * Values ["DEFAULT", "COOL"]

* `AppSettings.login_layout` one of
    * Layout of login screens
    * Values ["DEFAULT", "ILLUSTRATION", "COVER"]

* `AppSettings.multi_space_mode`
    * When true allows users to sign up and create spaces
    * When false allows only admin to invite users and create spaces
    * Values [true, false]

* `AppSettings.show_landing_page`
    * When true root path renders landing page
    * When false root path redirects to sign in page
    * Values [true, false]

## Deployment

* Deploy on [Fly.io](https://fly.io/docs/rails/getting-started/)
* Deploy on [Heroku](https://devcenter.heroku.com/articles/getting-started-with-rails7)

## Contribution

Contribution is welcome!