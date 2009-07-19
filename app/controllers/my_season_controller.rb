class MySeasonController < ApplicationController
    layout "standard"
    before_filter :authorize

    def index
        @season = Season.find params[:season_id]
    end
end