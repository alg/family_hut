module ActionController #:nodoc:
  class Base #:nodoc:
    attr_accessor :formats

    class_inheritable_accessor :mimes_for_respond_to, :responder, :instance_writer => false

    self.responder = ActionController::Responder
    self.mimes_for_respond_to = ActiveSupport::OrderedHash.new

    if defined?(ApplicationController)
      ApplicationController.responder ||= ActionController::Responder
      ApplicationController.mimes_for_respond_to ||= ActiveSupport::OrderedHash.new
    end

    # Defines mimes that are rendered by default when invoking respond_with.
    #
    # Examples:
    #
    #   respond_to :html, :xml, :json
    #
    # All actions on your controller will respond to :html, :xml and :json.
    #
    # But if you want to specify it based on your actions, you can use only and
    # except:
    #
    #   respond_to :html
    #   respond_to :xml, :json, :except => [ :edit ]
    #
    # The definition above explicits that all actions respond to :html. And all
    # actions except :edit respond to :xml and :json.
    #
    # You can specify also only parameters:
    #
    #   respond_to :rjs, :only => :create
    #
    def self.respond_to(*mimes)
      options = mimes.extract_options!
      clear_respond_to unless mimes_for_respond_to

      only_actions   = Array(options.delete(:only))
      except_actions = Array(options.delete(:except))

      mimes.each do |mime|
        mime = mime.to_sym
        mimes_for_respond_to[mime]          = {}
        mimes_for_respond_to[mime][:only]   = only_actions   unless only_actions.empty?
        mimes_for_respond_to[mime][:except] = except_actions unless except_actions.empty?
      end
    end

    # Clear all mimes in respond_to.
    def self.clear_respond_to
      write_inheritable_attribute(:mimes_for_respond_to, ActiveSupport::OrderedHash.new)
    end

    def respond_to(*mimes, &block)
      raise ArgumentError, "respond_to takes either types or a block, never both" if mimes.any? && block_given?
      if response = retrieve_response_from_mimes(mimes, &block)
        response.call
      end
    end

    def respond_with(*resources, &block)
      if response = retrieve_response_from_mimes([], &block)
        options = resources.extract_options!
        options.merge!(:default_response => response)
        (options.delete(:responder) || responder).call(self, resources, options)
      end
    end

  protected

    # Collect mimes declared in the class method respond_to valid for the
    # current action.
    #
    def collect_mimes_from_class_level #:nodoc:
      action = action_name.to_sym

      mimes_for_respond_to.keys.select do |mime|
        config = mimes_for_respond_to[mime]

        if config[:except]
          !config[:except].include?(action)
        elsif config[:only]
          config[:only].include?(action)
        else
          true
        end
      end
    end

    # Collects mimes and return the response for the negotiated format. Returns
    # nil if :not_acceptable was sent to the client.
    #
    def retrieve_response_from_mimes(mimes, &block)
      responder = ActionController::MimeResponds::Responder.new(self)
      mimes = collect_mimes_from_class_level if mimes.empty?
      mimes.each { |mime| responder.send(mime) }
      block.call(responder) if block_given?

      if format = responder.negotiate_mime
        self.response.template.template_format = format.to_sym
        self.response.content_type = format.to_s
        self.formats = [ format.to_sym ]
        responder.response_for(format) || proc { default_render }
      else
        head :not_acceptable
        nil
      end
    end
  end

  module MimeResponds
    class Responder #:nodoc:
      attr_reader :order

      def any(*args, &block)
        if args.any?
          args.each { |type| send(type, &block) }
        else
          custom(Mime::ALL, &block)
        end
      end
      alias :all :any

      def custom(mime_type, &block)
        mime_type = mime_type.is_a?(Mime::Type) ? mime_type : Mime::Type.lookup(mime_type.to_s)
        @order << mime_type
        @responses[mime_type] ||= block
      end

      def response_for(mime)
        @responses[mime] || @responses[Mime::ALL]
      end

      def negotiate_mime
        @mime_type_priority.each do |priority|
          if priority == Mime::ALL
            return @order.first
          elsif @order.include?(priority)
            return priority
          end
        end

        if @order.include?(Mime::ALL)
          return Mime::SET.first if @mime_type_priority.first == Mime::ALL
          return @mime_type_priority.first
        end

        nil
      end
    end
  end
end
