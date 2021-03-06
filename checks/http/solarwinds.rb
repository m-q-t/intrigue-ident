module Intrigue
module Ident
module Check
class Solarwinds < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["COTS"],
        :vendor => "SolarWinds",
        :product =>"Serv-U",
        :match_details =>"",
        :version => nil,
        :match_type => :content_headers,
        :match_content =>  /server: Serv-U/,
        :dynamic_version => lambda {|x| _first_header_capture(x, /server: Serv-U\/([\d\.]+)/)},
        :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
        :inference => true
      },
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["WebServer"],
        :vendor => "SolarWinds",
        :product =>"Nginx",
        :match_details =>"solarwinds nginx server header",
        :version => nil,
        :match_type => :content_headers,
        :match_content =>  /server: solarwinds-nginx/,
        :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
        :inference => false
      },
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["COTS", "Network", "Security"],
        :vendor => "SolarWinds",
        :product =>"Orion Platform",
        :match_details =>"solarwinds orion cookie",
        :match_type => :content_cookies,
        :match_content =>  /Orion_IsSessionExp=/,
        :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
        :inference => false
      },
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["COTS", "Network", "Security"],
        :vendor => "SolarWinds",
        :product =>"Orion Platform",
        :match_details =>"solarwinds worldwide string",
        :match_type => :content_body,
        :match_content =>  /SolarWinds Worldwide, LLC. All Rights Reserved.<\/div>/,
        :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
        :inference => false
      },
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["COTS", "Network", "Security"],
        :vendor => "SolarWinds",
        :product =>"Orion Platform",
        :match_details =>"solarwinds version string",
        :match_type => :content_body,
        :match_content =>  /Orion Platform ([\d\.]+\ ?[a-zA-z0-9]{3}?)/,
        :dynamic_version => lambda {|x| _first_body_capture(x, /Orion Platform ([\d\.]+\ ?[a-zA-z0-9]{3}?)/)},
        :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
        :inference => true
      },
      {
        :type => "fingerprint",
        :category => "application",
        :tags => ["COTS", "Network", "Security"],
        :vendor => "SolarWinds",
        :product =>"Orion Platform",
        :match_details =>"solarwinds version string",
        :match_type => :content_body,
        :match_content =>  /Orion Core ([\d\.]+\ ?[a-zA-z0-9]{3}?)/,
        :dynamic_version => lambda {|x| _first_body_capture(x, /Orion Core ([\d\.]+\ ?[a-zA-z0-9]{3}?)/)},
        :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
        :inference => true
      }
    ]
  end

end
end
end
end
