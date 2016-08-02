module Nlocal
  module Directory
    class Category < ApiBase
      validates :name, presence: true

      scope :root_categories, -> { where(parent_id: nil) }
    end
  end
end
