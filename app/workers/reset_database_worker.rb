class ResetDatabaseWorker
  include Sidekiq::Worker

  def perform
    reset_database
  end

  private

  def reset_database
    # Drop all tables
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.execute("DROP TABLE #{table} CASCADE") unless table == 'schema_migrations'
    end

    # Rerun migrations
    Rails.application.load_seed
  end
end
