module Nlocal
  module Directory
    class Admin < User
      include Nlocal::Directory::StiChild
      collection_path "users"
    end
  end
end
