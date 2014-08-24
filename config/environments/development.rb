Faselty::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  config.action_mailer.delivery_method = :letter_opener

  # these options are only needed if you choose smtp delivery
  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => true,  
    :address            => 'smtp.gmail.com',
    :port               => 587,
    :domain             => 'gmail.com', #you can also use google.com
    :authentication     => :plain,
    user_name: 'faselty.test@gmail.com',
    password: 'faselty.development'
  }

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
