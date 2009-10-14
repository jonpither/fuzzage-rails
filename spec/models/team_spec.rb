require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../app/models/team'
require 'mocha'

context "A team (in general)" do
    specify "should produce fixtures" do
        @season = Season.new

        @team = Team.new({:season => @season})

        @team2 = Team.new()
        @team3 = Team.new()

        @season.expects(:teams).returns [@team, @team2, @team3]

        fixtures = @team.fixtures

      fixtures.should include SeasonFixture.new(@team2)
      fixtures.should include SeasonFixture.new(@team3)
      fixtures.should_not include SeasonFixture.new(@team)
    end
end