# Load the Rails application.
require_relative 'application'
ENV['GOOGLE_APPLICATION_CREDENTIALS']='config/firestore.json'
# Initialize the Rails application.
Rails.application.initialize!
