module Nlocal
  module Directory
    class Comment < ApiBase
      belongs_to :user
      validates :body, presence: true

      scope :root_comments, -> { where(parent_id: nil).order('created_at DESC') }
    end
  end
end
