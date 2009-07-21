class MySeasonController < ApplicationController
  layout "standard"
  before_filter :authorize

  def index
    @team = Team.find params[:team_id]
    @season = @team.season
    @fixtures = @team.fixtures
  end
end