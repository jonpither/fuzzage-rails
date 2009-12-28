class AdminController < ApplicationController
    before_filter :authorize_admin
    
    layout "standard"

    def index
    end
end
