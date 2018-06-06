class UpdateCountryJob < ApplicationJob
  queue_as :default
  require 'json'
  require 'net/http'

  def perform(*args)
    CountryHelper::fetchCountryDetails
  end
end

