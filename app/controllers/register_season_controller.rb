class RegisterSeasonController < ApplicationController
    layout "standard"
    before_filter :authorize

    def register
        @season = Season.find params[:season_id]
        @team = Team.new
    end

    def join
        @season = Season.find params[:season_id]
        @team = Team.new(params[:team])
        @team.season = @season
        @team.user = session[:user]
        if @team.save

            redirect_to(:controller => 'home')
        else
            render :action => "register"
        end
    end
end