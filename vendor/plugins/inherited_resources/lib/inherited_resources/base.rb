require 'inherited_resources/blank_slate'
require 'inherited_resources/responder'

module InheritedResources
  # = Base
  #
  # This is the base class that holds all actions. If you see the code for each
  # action, they are quite similar to Rails default scaffold.
  #
  # To change your base behavior, you can overwrite your actions and call super,
  # call <tt>default</tt> class method, call <<tt>actions</tt> class method
  # or overwrite some helpers in the base_helpers.rb file.
  #
  class Base < ::ApplicationController
    unloadable

    # Overwrite inherit_resources to add specific InheritedResources behavior.
    #
    def self.inherit_resources(base)
      base.class_eval do
        include InheritedResources::Actions
        include InheritedResources::BaseHelpers
        extend  InheritedResources::ClassMethods
        extend  InheritedResources::UrlHelpers

        # Add at least :html mime type
        respond_to :html
        self.responder = InheritedResources::Responder

        helper_method :collection_url, :collection_path, :resource_url, :resource_path,
                      :new_resource_url, :new_resource_path, :edit_resource_url, :edit_resource_path,
                      :parent_url, :parent_path, :resource, :collection, :resource_class, :association_chain,
                      :resource_instance_name, :resource_collection_name

        base.with_options :instance_writer => false do |c|
          c.class_inheritable_accessor :resource_class
          c.class_inheritable_array :parents_symbols
          c.class_inheritable_hash :resources_configuration
        end

        protected :resource_class, :parents_symbols, :resources_configuration
      end
    end

    inherit_resources(self)
  end
end
