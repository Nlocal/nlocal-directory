module Nlocal
  module Directory
    class Advertiser < User
      include Nlocal::Directory::StiChild
      collection_path "users"

      belongs_to :agency
      has_many :ads
      delegate :contact_requests, to: :ads
    end
 end
end
