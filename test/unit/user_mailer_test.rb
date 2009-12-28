require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  tests UserMailer

  def test_register
    user = User.new(:name=>'Fred', :email=>'fred@fred.com')
    @expected.subject = 'Fuzzage: Confirm email address'
    @expected.body    = read_fixture('register')
    @expected.date    = Time.now
    @expected.to    = user.email

    assert_equal @expected.encoded, UserMailer.create_register(user, 'hashed_foo').encoded
  end

end
