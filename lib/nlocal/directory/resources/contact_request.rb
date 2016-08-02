module Nlocal
  module Directory
    class ContactRequest < ApiBase
     belongs_to :ad
     delegate :advertiser , to: :ad

     validates :ad , presence: true
    end
  end
end
