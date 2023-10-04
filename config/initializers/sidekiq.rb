# require 'sidekiq'
# require 'sidekiq-cron'

# Sidekiq::Cron::Job.create(
#   name: 'Reset Database Job - Daily',
#   cron: '0 0 * * *', # Run daily at midnight
#   class: 'ResetDatabaseWorker'
# )