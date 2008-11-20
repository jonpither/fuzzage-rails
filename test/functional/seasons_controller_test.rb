require 'test_helper'
require 'mocha'

class SeasonsControllerTest < ActionController::TestCase
    def setup
        @admin_user = User.new
        @admin_user.stubs(:has_role?).returns(true)
    end
    
    def test_should_get_index
        put @admin_user
        get :index,{}, {:user => @admin_user}
        assert_response :success
        assert_not_nil assigns(:seasons)
    end

    def test_should_get_new
        get :new, {},  {:user => @admin_user}
        assert_response :success
    end

    def test_should_create_season
        #Given
        params = { "name"=>'bastard'}
        stubbed_season = Season.new
        Season.expects(:new).with(params).returns(stubbed_season)
        stubbed_season.expects(:save).returns(true);

        post :create, {:season => { :name=>'bastard'}}, {:user => @admin_user}

        assert_redirected_to season_path(assigns(:season))
    end

    def test_should_show_season
        get :show, {:id => seasons(:one).id}, {:user => @admin_user}
        assert_response :success
    end

    def test_should_get_edit
        get :edit, {:id => seasons(:one).id}, {:user => @admin_user}
        assert_response :success
    end

    def test_should_update_season
        put :update, {:id => seasons(:one).id, :season => { :name => "hmmmm" }}, {:user => @admin_user}
        assert_redirected_to season_path(assigns(:season))
    end

    def test_should_destroy_season
        assert_difference('Season.count', -1) do
            delete :destroy, {:id => seasons(:one).id}, {:user => @admin_user}
        end

        assert_redirected_to seasons_path
    end
end
