module Nlocal
  module Directory
    class Ad  < ApiBase
      belongs_to :advertiser
      belongs_to :logo, class_name: "Image" , foreign_key: :logo_id, optional:true
      has_many :images
      has_many :contact_requests
      has_many :categories

      validates :advertiser_id, presence: true
      validates :title, presence: true

      def categorize(category_id)
        self.class.post("ads/#{self.id}/categories/#{category_id}",{})
        self.categories
      end

    end
  end
end
