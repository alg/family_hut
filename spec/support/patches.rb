# Fixes some deprecation warnings on Rails3
#module Authlogic
#  module ActsAsAuthentic
#    module SessionMaintenance
#      module Methods
#        def save_without_session_maintenance_with_rails3(*args)
#          args = { :validate => args.first } if [[false], [true]].include?(args)
#          save_without_session_maintenance_without_rails3(args)
#        end
#        alias_method_chain :save_without_session_maintenance, :rails3
#      end
#    end
#    module Password
#      module Methods
#        module InstanceMethods 
#        private
#          def transition_password(attempted_password)
#            self.password = attempted_password
#            save(:validate => false)
#          end
#        end
#      end
#    end
#  end
#end