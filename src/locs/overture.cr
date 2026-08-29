require "http/client"
require "json"

module Geks::Data
    class overture
        BASE_URL = "https://api.overturemapsapi.com"
        def self.geocode(city : String, country : String)
            params = URI::Params.encode({
                "query" => "#{city}, #{country}"
            })
            response = HTTP::Client.get(
                "#{BASE_URL}/geocode",
                headers: {"x-api-key" => ENV["OVERTURE_KEY"],
                query: params
                )
                data = JSON.parse(response.body)
                if response.status_code == 200
                    coords = data["features"][0]["geomatry"]["coordinates"].as_a
                    {
                        lat: coords[1].as_f,
                        lon: coords[2].as_f
                    }
                end
            end
            
            def self.search(city : String, country : String)
                coords = self.geocode(city, country)
                query = URI::Params.encode({
                    "lat" => coords[:lat].to_s,
                    "lng" => coords[:lon].to_s,
                    "radius" => "5000",
                    "limit" => "50",
                    "categories" => "shop, food_and_drink, health_and_beauty, professional_service"
                })
                response = HTTP::Client.get(
                    "#{BASE_URL}/places",
                    headers: {"x-api-key" => ENV["OVERTURE_KEY"]},
                    query: params
                    )
                    return JSON.parse(response.body)
                end
            end
        end
            