# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '95ccd577cc02e1ab505fdf1dfc72dd2d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
   filter_parameter_logging :password

    def authorize
        unless session[:user_id]
            flash[:notice] = "Please log in"
            redirect_to(:controller => "main", :action => "login")
        end
    end
end
