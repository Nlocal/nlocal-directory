module Nlocal
  module Directory
    class Region < ApiBase
      has_many :locations
      belongs_to :bucket

      before_create :ensure_bucket

      validates :name, presence: true

    end
  end
end
