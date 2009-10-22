require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../app/models/user'
require 'mocha'

context "A user (in general)" do
  specify "should be valid" do
    @user = User.new({:email => 'rolf@rolf.com', :name => 'Bob the builders son', :password => 'frodo', :confirm_password => 'frodo'})
    @user.save

    @user.should be_valid
    Role.create(:name => 'fpp')
  end

  specify "should be invalid without a name" do
    @user = User.new({:email => 'rolf@rolf.com', :password => 'frodo', :confirm_password => 'frodo'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:name).should == "can't be blank"
  end

  specify "should be invalid without an email address" do
    @user = User.new({:name => 'bobb', :password => 'frodo', :confirm_password => 'frodo'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:email).should == "can't be blank"
  end

  specify "should be invalid without a valid email address" do
    @user = User.new({:email => 'foo', :name => 'bobb', :password => 'frodo', :confirm_password => 'frodo'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:email).should == "must be a valid format"
  end

  specify "name should be above 2 chars" do
    @user = User.new({:name => 'b', :email => 'rolf@rolf.com', :password => 'frodo', :confirm_password => 'frodo'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:name).should == "is too short (minimum is 2 characters)"
  end

  specify "name should not be above 100 chars" do
    longname = ''
    0.upto(101) do |i|
      longname = "#{longname}a"
    end

    @user = User.new({:name => longname, :email => 'rolf@rolf.com', :password => 'frodo', :confirm_password => 'frodo'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:name).should == "is too long (maximum is 100 characters)"
  end

  specify "should be invalid without a password" do
    @user = User.new({:name => 'bobb', :email => 'rolf@rolf.com'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:password).should == "can't be blank"
  end

  specify "passwords should match" do
    @user = User.new({:name => 'bobb', :email => 'rolf@rolf.com', :password => 'frodo', :confirm_password => 'frodo2'})
    @user.save

    @user.errors.size.should == 1
    @user.errors.on(:confirm_password).should == "does not match"
  end

  specify "user_should_know_season_its_in" do
    season = Season.new
    user = User.new
    derby = Team.new({:user => user})

    assert !user.playing_in?(season)
    season.teams << derby
    user.teams << derby
    assert user.playing_in?(season)
  end

  specify "user should login" do
    #Given
    stubbed_user = User.new
    @user = User.new({:email => 'rolf@rolf.com', :password => 'frodo'})
    Digest::SHA1.expects(:hexdigest).with(@user.password).returns("barf")
    User.expects(:find).with(:first, :conditions => ["email = ? and hashed_password = ? and email_confirmed = true", "rolf@rolf.com", "barf"]).
            returns(stubbed_user)

    #When
    actual_user = @user.try_to_login

    #Then
    stubbed_user.should == actual_user
  end
end