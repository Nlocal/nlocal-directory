module Nlocal
  module Directory
    module Middleware
      class TokenAuthentication < Faraday::Middleware
        def call(env)
          env[:request_headers]["X-API-Token"] = RequestStore.store[:my_api_token]
          @app.call(env)
        end
      end
    end
  end
end
