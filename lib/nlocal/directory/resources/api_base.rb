module Nlocal
  module Directory
    class ApiBase
      include ::Her::Model
      uses_api Nlocal::Directory.configuration.api
    end
  end
end
