# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_authlogic_session',
  :secret      => 'ea25bc2f7b8f01e8324ba511ae021107c6e85d3c34583295d3a3a4cc03003cef3b552ffbd5da942f8da8d11661e3afb6e407a46e4a964656bf18b011c6eeeaa9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
