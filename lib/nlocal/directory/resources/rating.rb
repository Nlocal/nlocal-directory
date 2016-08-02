module Nlocal
  module Directory
    class Rating < ApiBase
      belongs_to :user

      validates :score, presence: true
    end
  end
end
