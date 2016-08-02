require_relative "errors"
module Nlocal
  module Directory
    module Middleware

      class Oauth < Faraday::Middleware
        def call(env)
          env[:request_headers]["Authorization"] = "bearer " + ::RequestStore.store[:token].access_token if ::RequestStore.store[:token]
          @app.call(env).on_complete do |response_env|
            case response_env[:status]
            when 401
                raise Unauthorized, 'Invalid Credentials'
            end
          end
        end
      end

    end
  end
end
