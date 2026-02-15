# frozen_string_literal: true

Devise.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Devise::Mailer.
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  # ==> ORM configuration
  require "devise/orm/active_record"

  # ==> Controller configuration
  # Tell Devise to use our custom controller that handles Turbo status codes (422)
  config.parent_controller = "TurboDeviseController"

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [ :http_auth ]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  # ==> Navigation configuration
  # Adding :turbo_stream here is vital for redirects to work!
  config.navigational_formats = [ "*/*", :html, :turbo_stream ]

  # ==> Warden configuration
  # This block is where the 'manager' variable is defined.
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end

  # ==> Hotwire/Turbo configuration
  # These ensure Devise sends the correct status codes that Turbo expects.
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end

# --- CUSTOM CLASSES FOR TURBO SUPPORT ---
# These sit OUTSIDE the Devise.setup block.

# This handles the login failure redirects (e.g., wrong password)
class TurboFailureApp < Devise::FailureApp
  def respond
    if request_format == :turbo_stream
      redirect
    else
      super
    end
  end

  def skip_format?
    %w[html turbo_stream */*].include? request_format.to_s
  end
end
