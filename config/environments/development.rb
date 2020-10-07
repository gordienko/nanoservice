Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.session_store :cache_store

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  config.active_job.queue_adapter     = :sidekiq
  config.active_job.queue_name_prefix = "nanoservice_development"


  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
        'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  config.action_mailer.delivery_method = :elastic_email
  config.action_mailer.elastic_email_settings = {
      api_key: Rails.application.credentials.dig(Rails.env.to_sym, :elastic_email_api_key),
      username: Rails.application.credentials.dig(Rails.env.to_sym, :elastic_email_username),
      domain: Rails.application.credentials.dig(Rails.env.to_sym, :elastic_email_domain)
  }
  config.action_mailer.default_url_options = {
      host: Rails.application.credentials.dig(Rails.env.to_sym, :domain_name),
      from: Rails.application.credentials.dig(Rails.env.to_sym, :elastic_email_from) }

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  config.hosts.clear
  config.action_cable.url = 'wss://dev.smphost.com/cable'
  config.action_cable.allowed_request_origins = [
      'https://dev.smphost.com',
      /https:\/\/dev.smphost.com.*/,
      'http://localhost:3000'
  ]
end
