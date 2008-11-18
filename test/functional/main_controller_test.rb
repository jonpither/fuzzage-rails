require 'test_helper'

class MainControllerTest < ActionController::TestCase
    def test_new_user_created_when_get_request_is_made
        get :register
        user = assigns(:user)

        assert user.new_record?
        assert_nil user.id
        assert_nil user.name
        assert_nil user.email

        assert_response :success
    end

    def test_new_user_saved_when_post_request_is_made
        post :register, :user => { :name=>'bastard', :email=>'foo@foo.com', :password=>'password', :confirm_password=>'password'}

        user = assigns(:user)

        assert !user.new_record?
        assert_redirected_to :action => "index"
    end
end
