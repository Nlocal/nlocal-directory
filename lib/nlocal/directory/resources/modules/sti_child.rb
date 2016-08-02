module Nlocal
  module Directory
   module StiChild

     def self.included(base)
       base.extend(ClassMethods)
       base.send :include , InstanceMethods
       base.send :before_save , :set_type
     end

     module InstanceMethods
       def set_type
         self.type = self.class.name.demodulize
       end
     end

     module ClassMethods
     end

   end
  end
end
