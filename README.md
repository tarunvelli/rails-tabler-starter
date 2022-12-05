# Rails-tabler Boilerplate

Rails boilerplate that you can clone and build on top off

* User authentication & authorization

    * Authentication through [Devise](https://github.com/heartcombo/devise)
    * Authorization thought [Pundit](https://github.com/varvet/pundit)

* Role managrment

    * Supports standard roles available across spaces and also custom roles per space

* Multi-tenant architeture

    * The `Space` model is used to represent a tenant i.e. can be a team, organization, group etc.

* Pre built UI layouts

    * Using the beautiful UI elements and layouts from [Tabler](https://tabler.io/)

## Goals

Users familiar with rails should be able to build with this boilerplate without requiring extensive introduction.

* No DSL
* Avoid complex frontend functionality
* Simplicity over efficiency
* Not to be made into a gem/engine
* Minimum dependencies

## Setup

```
git clone http:<insert url>
cd folder
bundle install
yarn install
bundle exec rails db:setup
bin/dev
```

## Deployment

TODO: instructions to deploy on fly.io etc.

## Contribution

Contribution is welcome!