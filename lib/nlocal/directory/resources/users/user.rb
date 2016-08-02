module Nlocal
  module Directory
    class User < ApiBase
      validates :username, presence: true
      validates :email, presence: true

      has_many :messages
      has_many :comments

      def me
        get("/me")
      end
    end
  end
end
