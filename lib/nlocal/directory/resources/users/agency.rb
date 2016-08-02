module Nlocal
  module Directory
   class Agency < User
     include Nlocal::Directory::StiChild
     collection_path "users"

     has_many :advertisers
     delegate :ads , to: :advertisers
   end
 end
end
