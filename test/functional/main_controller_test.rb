require 'test_helper'
require 'mocha'

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
        # Given:
        user_args = { 'name' => 'bastard', 'email' => 'foo@foo.com', 'password' =>'password', 'confirm_password' =>'password'}
        stubbed_user = User.new({:name=>'freddo'})
        User.expects(:new).with(user_args).returns(stubbed_user)
        stubbed_user.expects(:save).returns(true)

        Digest::SHA1.expects(:hexdigest).with("#{stubbed_user.name}secret word").returns("barf")
        UserMailer.expects(:deliver_register).with(stubbed_user, "barf")

        #When:
        post :register, :user => user_args

        #Then:
        assert_redirected_to :action => "index"
    end

    def test_confirm_user_from_hashed_name
        # Given:
        user1 = User.new({:name=>'bobmarley'})
        user2 = User.new({:name=>'bobmarley2'})
        stubbed_users = [user1, user2]
        User.expects(:find).with(:all).returns(stubbed_users)

        Digest::SHA1.expects(:hexdigest).with("bobmarleysecret word").returns("hash1")
        Digest::SHA1.expects(:hexdigest).with("bobmarley2secret word").returns("hash2")

        user2.expects(:update_attributes).with({:email_confirmed => true})

        #When:
        post :confirm_email, :hash => 'hash2'

        #Then
        assert_redirected_to :action => "index"
    end

    def test_get_request_to_login_page
        get :login
        assert_response :success
    end

    def test_successful_login
        #Given
        user_args = {'email' => 'foo@foo.com', 'password' => 'pass'}
        user = User.new()
        user_in_db = User.new()
        user_in_db.id=4

        User.expects(:new).with(user_args).returns(user)
        user.expects(:try_to_login).returns(user_in_db)

        #when
        post :login, :user => user_args

        #Then
        assert_redirected_to :action => "index"
        assert_equal user_in_db, session.data["user"]
    end

    def test_unsuccessful_login
        #Given
        user_args = {'email' => 'foo@foo.com', 'password' => 'pass'}
        user = User.new('password' => 'pass')

        User.expects(:new).with(user_args).returns(user)
        user.expects(:try_to_login).returns(nil)

        #when
        post :login, :user => user_args

        #Then
        assert_response :success
        assert_equal '', user.password
        assert_nil session.data["user_id"]
    end

   def test_logout
        #when
        get :logout

        #Then
        assert_redirected_to :action => "index"
        assert_nil session.data["user_id"]
    end
end
