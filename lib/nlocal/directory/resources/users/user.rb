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

      def self.find(*args)
        obj= super
        obj.becomes "Nlocal::Directory::#{obj.type}".constantize if obj.type
      end

    end
  end
end
