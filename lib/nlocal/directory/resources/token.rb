module Nlocal
  module Directory
    class Token
     include ::Her::Model
     uses_api Nlocal::Directory.configuration.oauth
     collection_path "token"

     custom_get :info
     before_save :default_params

     def revoke
       put("/revoke/",{token: id})
     end

     def default_params
      self.email ||= ::RequestStore.store[:user]
      self.password ||= ::RequestStore.store[:password]
      self.grant_type = "password"
     end
    end
  end
end
