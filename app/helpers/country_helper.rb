module CountryHelper
    def self.fetchCountryDetails
        @ips=Visit.distinct.pluck(:ip)
        @ips.each do |ip|
          url="https://ipinfo.io/#{ip}?"
          url=url+"token=#{Rails.application.credentials.ipinfo[:api_token]}"
          uri=URI(url)
          response=Net::HTTP.get(uri)
          ipinfo=JSON.parse(response)
          puts ipinfo
          country=ipinfo["country"]
          puts "'#{country}'"
          Visit.where("ip = ? ",ip).update_all("country='#{country}'")
        end
    end
end