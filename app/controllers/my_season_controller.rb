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
  end

  def record_result
    @team = Team.find params[:team_id]
    @opponent_team = Team.find params[:opponent_team_id]

    @home_score = Score.new(params[:home_score])
    @away_score = Score.new(params[:away_score])

    @home_score.team = @team
    @away_score.team = @opponent_team

    my_result = Result.new({:scores => [@home_score, @away_score]})

    if my_result.save
      redirect_to(:action => "index", :team_id => @team.id)
    else
      flash[:notice] = "Invalid score(s)"
      render (:action => "play_fixture", :team_id => @team.id, :opponent_team_id => @opponent_team.id)
    end
  end
end