require "http/client"

module Geks::Data
    class Google
        def self.search(city : String)
            params = URI::Params.encode({
                "query" => city,
                "type" => "business",
                "key" => ENV["GOOGLE_KEY"]
            })
            response = HTTP::Client.get(
                "https://maps.googleapis.com/maps/api/place/textsearch/json",
                query: params
                )
                
                data = JSON.parse(response.body)
                if response.status_code == 200
                    b = data["results"].as_a.map do |place|
                        existing = Geks::Db::data.find_business_id(place["places_id"].as(String))
                        if existing
                            {
                                "id" => existing["id"],
                                "name" => existing["name"],
                                "address" => existing["address"],
                                "phone" => existing["phone"],
                                "lat" => existing["lat"],
                                "lon" => existing["lon"],
                                "rating" => existing["rating"],
                                "check_in" => existing["check_in"],
                                "is_locked" => existing["is_locked"]
                            }
                        else
                           business = Geks::Data::Main.create(
                                place["places_id"].to_s,
                                place["name"].to_s
                                place["formatted_address"].to_s,
                                place["formatted_phone_number"].to_s,
                                place["geomatry"]["location"]["lat"].as_f,
                                place["geomatry"]["location"]["lng"].as_f,
                                0.0,
                                false
                                )
                                return business
                            end
                        end
                    end
                end
            end
        end
            