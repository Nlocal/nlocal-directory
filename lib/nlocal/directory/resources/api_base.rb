module Nlocal
  module Directory
    class ApiBase
      include ::Her::Model
      uses_api Nlocal::Directory.configuration.api

      def becomes(klass)
        klass.new.tap do |became|
          became.instance_variable_set("@attributes", @attributes)
          became.instance_variable_set("@attributes_cache", @attributes_cache)
          became.instance_variable_set("@new_record", new_record?)
        end
      end
    end
  end
end
