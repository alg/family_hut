# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_family_hut_session',
  :secret      => 'ae863c84e5ae2695c315342c0922a6a2ba50da365600cc59d05eec356bcab224e4ec7d0b014a07045329edc1addceca66855b53d82d62690d38d88a6905ece6c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
