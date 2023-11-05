# The Statistic configuration is an initializer that GEM
# uses to configure itself. The option max_timelist_length
# is used to avoid memory leak, in practice, whenever the
# cache size reaches that number, the GEM is going to
# remove 25% of the key values, avoiding inflating memory.
Sidekiq::Statistic.configure do |config|
  config.max_timelist_length = 100_000
end
