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
end
