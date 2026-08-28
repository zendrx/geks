require "crypto/bcrypt/password"
require "jwt"

module Geks
    class Auth
        def self.signup(email : String, password : String, username : String) : Hash(String, String)
            e, u = Geks::Db::Auth.check_mail_username(email, username)
            if e == true
                return {
                    "success" => "false",
                    "message" => "email has been taken"
                }
                elsif u == true
                return {
                    "success" => "false",
                    "message" => "username taken"
                }
            else 
                hash_p = Crypto::Bcrypt::Password.create(password).to_s
                user_id = Geks::Db::Auth.create_user(email, hash_p, username)
                return {
                    "success" => "true",
                    "message" => user_id
                }
            end
        end
        
        def self.login(username : String, password : String) : Hash(String, String)
            id, prev_h = Geks::Db::Auth.get_pass(username)
            return {"success" => "false", "message" => "wrong username/invalid account"} unless id
            pswd = Crypto::Bcrypt::Password.new(prev_h)
            if pswd.verify(password)
                return {
                    "success" => "true",
                    "message" => id
                }
            else
                {
                    "success" => "false"
                    "message" => "wrong password"
                }
            end
        end
    end
end
            