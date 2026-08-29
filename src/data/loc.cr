require "../loc/*"

module Geks::Data
    class Main
        def self.create(id : String, name : String, address: String, phone : String, lat : Float, lng : Float, ratings : Float, locked : Bool)
            Geks::Db::Data.create(id, name, address, phone, lat, lng, ratings, locked)
            return {
                "id" => id,
                "name" => name,
                "address" => address,
                "phone" => phone,
                "lat" => lat,
                "lon" => lng,
                "ratings" => ratings,
                "is_locked" => locked
            }
        end
        
        def self.search(city : String, country : String)
            google = Geks::Data::Google.search(city)
            if google == 500
                overture = Geks::Data::Overture.search(city, country)
                return overture
            else
                return google
            end
        end
    end
end
                
        