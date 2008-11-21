class RegisterSeasonController < ApplicationController
    layout "standard"
    before_filter :authorize

    def register
        @season = Season.find params[:season_id]
        @team = Team.new
    end

    def join
       redirect_to(:controller => 'home') 
    end
end