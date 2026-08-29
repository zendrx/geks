require "../data/*"
require "kemal"

get "/api/loc" do |env|
    id = env.request.headers["Authorization"]?
     if id && id.starts_with?("Bearer ")
         user_id = id[7..-1]
         exists = Geks::Db::Auth.check_id(id)
         if exists
             city = env.params.query["city"].as(String)
             country = env.params.query["city"].as(String)
             bus = Geks::Data::Main.search(city, country)
             bus.to_json
         else
             {"unauthorized user"}.to_json
         end
     else
         {"invalid or no user_id"}.to_json
     end
end
    

