require_relative "errors"
module Nlocal
  module Directory
    module Middleware

      class Authentication < Faraday::Middleware
        def call(env)
          env[:request_headers]["Accept"] = "application/vnd.#{configuration.vendor}-#{configuration.version}+json"
          env[:request_headers]["Authorization"] = "bearer " + ::RequestStore.store[:token] if ::RequestStore.store[:token]
          @app.call(env).on_complete do |response_env|
            case response_env[:status]
            when 401
                raise Unauthorized, 'Invalid Credentials'
            when 406
                raise UnaceptableResponse, 'Accept header not supported'
            end
          end
        end
      end

    end
  end
end
