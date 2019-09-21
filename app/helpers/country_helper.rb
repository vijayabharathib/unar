module CountryHelper
    def self.fetchCountryDetails
        @ips=Visit.where(country:nil).or(Visit.where(country:"")).distinct.pluck(:ip)
        @ips.each do |ip|
          url="https://ipinfo.io/#{ip}?"
          url=url+"token=#{Rails.application.credentials.ipinfo[:api_token]}"
          uri=URI(url)
          response=Net::HTTP.get_response(uri)
          if response.code.eql?("200")
            ipinfo=JSON.parse(response)
            country=ipinfo["country"]
            Visit.where("ip = ? ",ip).update_all("country='#{country}'")
          else
            p "Unable to get IP->Country info: #{response.message}"
          end

          break unless response.code.eql?("200")
        end
    end

    def self.find_or_create_ip_info(ip) 
        info = CountryMap.find_by(ip: ip)
        if !info.nil? 
          return info.country 
        else 
          url="https://ipinfo.io/#{ip}?"
          url=url+"token=#{Rails.application.credentials.ipinfo[:api_token]}"
          uri=URI(url)
          response=Net::HTTP.get_response(uri)
          if response.code.eql?("200")
            country = JSON.parse(response)['country'] 
            CountryMap.new(ip: ip, country: country).save
            return country 
          else 
            p "Error fetching IP info. Response: #{response.code}; Message: #{response.message}"
            return ""
          end
        end
    end

end