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

    @home_score = Score.new({:team => @team})
    @away_score = Score.new({:team => @opponent_team})

    @my_result = Result.new
  end

  def record_result
    home_team = Team.find params[:home_team_id]
    away_team = Team.find params[:away_team_id]

    @home_score = Score.new(params[:home_score])
    @away_score = Score.new(params[:away_score])

    @home_score.team = home_team
    @away_score.team = away_team

    my_result = Result.new({:scores => [@home_score, @away_score]})
    my_result.save

    redirect_to(:action => "index", :team_id => home_team.id)
  end
end