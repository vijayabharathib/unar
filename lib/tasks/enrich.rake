namespace :enrich do
  desc "Get Country Info From IP"
  task country_info: :environment do
    UpdateCountryJob.perform_now
  end

end
