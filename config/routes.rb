ActionController::Routing::Routes.draw do |map|

  SprocketsApplication.routes(map)

  map.resource          :user_session
  map.resource          :account, :controller => "users"
  map.resources         :users
  map.resources         :albums do |a|
    a.resources         :photos,
                          :collection => { :new_ten => :get, :create_ten => :post, :update_title => :post },
                          :member => { :create_comment => :post }
  end

  map.login       '/login',           :controller => "user_sessions", :action => "new"
  map.logout      '/logout',          :controller => "user_sessions", :action => "destroy"
  map.dashboard   '/',                :controller => "users", :action => "dashboard"
  map.new_post    '/new_post',        :controller => "users", :action => "new_post"
  map.delete_post '/delete_post/:id', :controller => "users", :action => "delete_post"
  map.root                            :controller => "users", :action => "dashboard"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
