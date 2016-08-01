module Nlocal
  module Directory
    class User
      include ::Her::Model
      uses_api Nlocal::Directory.configuration.api

      def me
        get("/me")
      end
    end
  end
end
