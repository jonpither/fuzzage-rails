require 'test_helper'
require 'mocha'

class MySeasonControllerTest < ActionController::TestCase
    def setup
        @user = User.new
        @user.stubs(:has_role?).returns(true)
    end

  def test_should_create_result
    #Given
    home_team = teams(:derby)
    away_team = teams(:forest)

    #When:
    post :record_result, {:home_team_id => home_team.id, :away_team_id => away_team.id}, {:user => @user}

    #Then:
    #assert_redirected_to index_path(assigns(:season))
  end
end
