require "kemal"
require "../auth/*"

post "/api/signup" do |env|
 email = env.params.json["email"].as(String)
 psswd = env.params.json["password"].as(String)
 username = env.params.json["username"].as(String)
 signup = Geks::Auth.signup(email, psswd, username)
 signup.to_json
 end
 
 post "/api/login" do |env|
     uname = env.params.json["username"].as(String)
     psswd = env.params.json["password"].as(String)
     login = Geks::Auth.login(usernam, psswd)
     login.to_json
 end
 
 post "/api/forget" do |env|
     username = env.params.json["username"].as(String)
     email = env.params.json["email"].as(String)
     new_pswd = env.params.json["new_pswd"].as(String)
     fg = Geks::Auth.forget(email, username)
     fg.to_json
 end
 
 post "/api/me" do |env|
     id = env.request.headers["Authorization"]?
     if id && id.starts_with?("Bearer ")
         user_id = id[7..-1]
     db = Geks::Db::User.get_user_data(user_id)
     db.to_json
 end
 