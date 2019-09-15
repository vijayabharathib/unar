module CountryHelper
    def self.fetchCountryDetails
        @ips=Visit.where(country:nil).or(Visit.where(country:"")).distinct.pluck(:ip)
        @ips.each do |ip|
          url="https://ipinfo.io/#{ip}?"
          url=url+"token=#{Rails.application.credentials.ipinfo[:api_token]}"
          uri=URI(url)
          response=Net::HTTP.get_response(uri)
          if response.code == 200
            ipinfo=JSON.parse(response)
            country=ipinfo["country"]
            Visit.where("ip = ? ",ip).update_all("country='#{country}'")
          else
            p "Unable to get IP->Country info: #{response.message}"
          end

          break if response.code != 200
        end
    end
end