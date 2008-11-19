class HomeController < ApplicationController
    layout "standard"
    before_filter :authorize
    
    def index
        #
    end
end
