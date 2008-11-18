require 'test_helper'

class SeasonsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:seasons)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_season
    assert_difference('Season.count') do
      post :create, :season => { :name=>'bastard'}
    end

    assert_redirected_to season_path(assigns(:season))
  end

  def test_should_show_season
    get :show, :id => seasons(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => seasons(:one).id
    assert_response :success
  end

  def test_should_update_season
    put :update, :id => seasons(:one).id, :season => { :name => "hmmmm" }
    assert_redirected_to season_path(assigns(:season))
  end

  def test_should_destroy_season
    assert_difference('Season.count', -1) do
      delete :destroy, :id => seasons(:one).id
    end

    assert_redirected_to seasons_path
  end
end
