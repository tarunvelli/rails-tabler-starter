# frozen_string_literal: true

SettingsCache = Redis::Namespace.new('settings', redis: Redis.new)
