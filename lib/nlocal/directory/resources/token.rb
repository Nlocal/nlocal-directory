module Nlocal
  module Directory
    class Token
     include ::Her::Model
     uses_api Nlocal::Directory.configuration.oauth
     collection_path "token"

     custom_get :info
     before_save :default_params

     def revoke
       put("revoke",{token: self.access_token})
     end

     def default_params
      self.email = ::RequestStore.store[:user] if !self.respond_to?(:email) || !self.email
      self.password = ::RequestStore.store[:password] if !self.respond_to?(:password) || !self.password
      self.grant_type = "password" if !self.respond_to?(:grant_type) || !self.grant_type
     end

     def self.refresh_token
       ::RequestStore[:token]= self.create
     end

    end
  end
end
