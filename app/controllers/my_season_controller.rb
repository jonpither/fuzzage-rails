class MySeasonController < ApplicationController
  layout "standard"
  before_filter :authorize

  def index
    @team = Team.find params[:team_id]
    @season = @team.season
    @fixtures = @team.fixtures
  end

  def play_fixture
    @team = Team.find params[:team_id]
    @season = @team.season
    @opponent_team = Team.find params[:opponent_team_id]

    @my_result = Result.new
  end

  def record_result
    home_team = Team.find params[:home_team_id]
    away_team = Team.find params[:away_team_id]

    my_result = Result.new(params[:my_result])
    my_result.home_team = home_team
    my_result.away_team = away_team
    my_result.save

    redirect_to(:action => "index", :team_id => my_result.home_team.id)
  end
end