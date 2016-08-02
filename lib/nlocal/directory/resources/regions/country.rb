module Nlocal
  module Directory
    class Country < Region
      include Nlocal::Directory::StiChild
      collection_path "regions"
    end
  end
end
