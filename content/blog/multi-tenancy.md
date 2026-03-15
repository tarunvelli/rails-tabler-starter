---
title: Multi-Tenancy in Rails Tabler Starter
summary: Learn how Rails Tabler Starter handles multiple tenants using the apartment gem pattern.
date: 2024-02-20
author: RailsTabler Team
category: Tutorial
published: true
---

# Multi-Tenancy in Rails Tabler Starter

Rails Tabler Starter comes with built-in multi-tenancy support, allowing you to serve multiple organizations or "spaces" from a single application.

## What is Multi-Tenancy?

Multi-tenancy is an architecture where a single application serves multiple customers (tenants), keeping their data isolated from each other.

## How It Works in Rails Tabler Starter

The starter uses a `Space` model to represent each tenant:

```ruby
class Space < ApplicationRecord
  has_many :users
  has_many :subscriptions
end
```

Each user belongs to a space, and all data can be scoped to the current space.

## Scoping Data

In controllers, data is automatically scoped to the current space:

```ruby
class TasksController < ApplicationController
  def index
    @tasks = current_space.tasks
  end
end
```

## Space Switching

Users can switch between spaces they belong to using the dropdown in the header:

```erb
<%= render "spaces/switcher" %>
```

## Subscription Management

Each space can have an active subscription:

```ruby
class Space < ApplicationRecord
  has_one :subscription
  has_active_subscription?
end
```

Stripe webhooks automatically update subscription status.

## Benefits

1. **Single codebase** - No need to maintain separate deployments
2. **Data isolation** - Each space's data is completely separate
3. **Easy management** - Admin can create and manage spaces from Rails Admin
4. **Flexible** - Add new tenants on the fly without infrastructure changes

## Getting Started

1. Create a new space from Rails Admin
2. Add users to the space
3. Users will automatically see only their space's data

That's it! Your multi-tenant app is ready to go.