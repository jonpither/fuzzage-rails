class RegisterSeasonController < ApplicationController
    layout "standard"
    before_filter :authorize

    def register
        @season = Season.find params[:season_id]
    end
end