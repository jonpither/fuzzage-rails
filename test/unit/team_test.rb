require 'test_helper'

class TeamTest < ActiveSupport::TestCase
    def setup
        @user = User.new ({ 'name' => 'bastard', 'email' => 'foo@foo.com', 'password' =>'password', 'confirm_password' =>'password'})
        @user.save
        @season = Season.new ({:name => "2008"})
    end

    def test_truth
        team = Team.new({:name => 'foo fighters', :user => @user, :season => @season})
        team.save
        assert !team.new_record?, "#{team.errors.full_messages.to_sentence}"

        reloaded_team = Team.find(team.id)
        assert_equal @user, reloaded_team.user
        assert_equal @season, reloaded_team.season
    end

    def test_errors_on_name
        team = Team.new({:name => nil})
        team.save
        assert team.errors.on(:name)
    end

    def test_length_of_name_minimum
        team = Team.new({:name => '123'})
        team.save
        assert team.errors.on(:name)
    end

    def test_length_of_name_maximum
        team = Team.new({:name => '123456789012345678901234567890123456789012345678901'})
        team.save
        assert team.errors.on(:name)
    end
end
