require 'test_helper'

class MySeasonControllerTest < ActionController::TestCase
  fixtures :all
  
  def setup
    @user = User.new
    @user.stubs(:has_role?).returns(true)
  end

  def test_should_create_result
    #Given
    home_team = teams(:derby)
    away_team = teams(:forest)

    #When:
    post :record_result, {:team_id => home_team.id, :opponent_team_id => away_team.id, :home_score => {:score=>5}, :away_score => {:score=>0}}, {:user => @user}

    #Then:
    #assert_redirected_to index_path(assigns(:season)) todo finish this
  end
end
