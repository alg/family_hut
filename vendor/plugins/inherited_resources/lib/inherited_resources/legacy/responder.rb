module ActionController #:nodoc:
  # Responder is responsible to expose a resource for different mime requests,
  # usually depending on the HTTP verb. The responder is triggered when
  # respond_with is called. The simplest case to study is a GET request:
  #
  #   class PeopleController < ApplicationController
  #     respond_to :html, :xml, :json
  #
  #     def index
  #       @people = Person.find(:all)
  #       respond_with(@people)
  #     end
  #   end
  #
  # When a request comes, for example with format :xml, three steps happen:
  #
  #   1) responder searches for a template at people/index.xml;
  #
  #   2) if the template is not available, it will invoke :to_xml in the given resource;
  #
  #   3) if the responder does not respond_to :to_xml, call :to_format on it.
  #
  # === Builtin HTTP verb semantics
  #
  # Rails default responder holds semantics for each HTTP verb. Depending on the
  # content type, verb and the resource status, it will behave differently.
  #
  # Using Rails default responder, a POST request for creating an object could
  # be written as:
  #
  #   def create
  #     @user = User.new(params[:user])
  #     flash[:notice] = 'User was successfully created.' if @user.save
  #     respond_with(@user)
  #   end
  #
  # Which is exactly the same as:
  #
  #   def create
  #     @user = User.new(params[:user])
  #
  #     respond_to do |format|
  #       if @user.save
  #         flash[:notice] = 'User was successfully created.'
  #         format.html { redirect_to(@user) }
  #         format.xml { render :xml => @user, :status => :created, :location => @user }
  #       else
  #         format.html { render :action => "new" }
  #         format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
  #       end
  #     end
  #   end
  #
  # The same happens for PUT and DELETE requests.
  #
  # === Nested resources
  #
  # You can given nested resource as you do in form_for and polymorphic_url.
  # Consider the project has many tasks example. The create action for
  # TasksController would be like:
  #
  #   def create
  #     @project = Project.find(params[:project_id])
  #     @task = @project.comments.build(params[:task])
  #     flash[:notice] = 'Task was successfully created.' if @task.save
  #     respond_with(@project, @task)
  #   end
  #
  # Giving an array of resources, you ensure that the responder will redirect to
  # project_task_url instead of task_url.
  #
  # Namespaced and singleton resources requires a symbol to be given, as in
  # polymorphic urls. If a project has one manager which has many tasks, it
  # should be invoked as:
  #
  #   respond_with(@project, :manager, @task)
  #
  # Check polymorphic_url documentation for more examples.
  #
  class Responder
    attr_reader :controller, :request, :format, :resource, :resources, :options

    ACTIONS_FOR_VERBS = {
      :post => :new,
      :put => :edit
    }

    def initialize(controller, resources, options={})
      @controller = controller
      @request = controller.request
      @format = controller.formats.first
      @resource = resources.is_a?(Array) ? resources.last : resources
      @resources = resources
      @options = options
      @action = options.delete(:action)
      @default_response = options.delete(:default_response)
    end

    delegate :head, :render, :redirect_to,   :to => :controller
    delegate :get?, :post?, :put?, :delete?, :to => :request

    # Undefine :to_json and :to_yaml since it's defined on Object
    undef_method(:to_json) if method_defined?(:to_json)
    undef_method(:to_yaml) if method_defined?(:to_yaml)

    # Initializes a new responder an invoke the proper format. If the format is
    # not defined, call to_format.
    #
    def self.call(*args)
      new(*args).respond
    end

    # Main entry point for responder responsible to dispatch to the proper format.
    #
    def respond
      method = :"to_#{format}"
      respond_to?(method) ? send(method) : to_format
    end

    # HTML format does not render the resource, it always attempt to render a
    # template.
    #
    def to_html
      default_render
    rescue ActionView::MissingTemplate => e
      navigation_behavior(e)
    end

    # All others formats follow the procedure below. First we try to render a
    # template, if the template is not available, we verify if the resource
    # responds to :to_format and display it.
    #
    def to_format
      default_render
    rescue ActionView::MissingTemplate => e
      raise unless resourceful?
      api_behavior(e)
    end

  protected

    # This is the common behavior for "navigation" requests, like :html, :iphone and so forth.
    def navigation_behavior(error)
      if get?
        raise error
      elsif has_errors? && default_action
        render :action => default_action
      else
        redirect_to resource_location
      end
    end

    # This is the common behavior for "API" requests, like :xml and :json.
    def api_behavior(error)
      if get?
        display resource
      elsif has_errors?
        display resource.errors, :status => :unprocessable_entity
      elsif post?
        display resource, :status => :created, :location => resource_location
      else
        head :ok
      end
    end

    # Checks whether the resource responds to the current format or not.
    #
    def resourceful?
      resource.respond_to?(:"to_#{format}")
    end

    # Returns the resource location by retrieving it from the options or
    # returning the resources array.
    #
    def resource_location
      options[:location] || resources
    end

    # If a given response block was given, use it, otherwise call render on
    # controller.
    #
    def default_render
      @default_response.call
    end

    # display is just a shortcut to render a resource with the current format.
    #
    #   display @user, :status => :ok
    #
    # For xml request is equivalent to:
    #
    #   render :xml => @user, :status => :ok
    #
    # Options sent by the user are also used:
    #
    #   respond_with(@user, :status => :created)
    #   display(@user, :status => :ok)
    #
    # Results in:
    #
    #   render :xml => @user, :status => :created
    #
    def display(resource, given_options={})
      controller.send :render, given_options.merge!(options).merge!(format => resource)
    end

    # Check if the resource has errors or not.
    #
    def has_errors?
      resource.respond_to?(:errors) && !resource.errors.empty?
    end

    # By default, render the :edit action for html requests with failure, unless
    # the verb is post.
    #
    def default_action
      @action ||= ACTIONS_FOR_VERBS[request.method]
    end
  end
end