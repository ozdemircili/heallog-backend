module Humanapi
  class Auth 
    include HTTParty
    base_uri 'https://user.humanapi.co/v1'

    def self.finish_auth(params)
      puts params
      response = post("/connect/tokens", body: params.to_json, 
                      headers: {"Content-Type" => "application/json"} )

      puts response.body
      JSON.parse response.body
    end
  end
end

