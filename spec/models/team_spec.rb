require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../app/models/team'
require 'mocha'

context "A team (in general)" do
  before(:each) do
    @season = Season.new
    @team = Team.new({:season => @season, :name => 'team1', :results => []})
    @team2 = Team.new({:name => 'team2'})
    @team3 = Team.new({:name => 'team3'})

    @season.expects(:teams).returns [@team, @team2, @team3]
  end

  specify "should produce fixtures" do
    fixtures = @team.fixtures

    fixtures.should include SeasonFixture.new(@team2)
    fixtures.should include SeasonFixture.new(@team3)
    fixtures.should_not include SeasonFixture.new(@team)
  end

  specify "should produce fixtures" do
    result = Result.new
    result.expects(:teams).returns [@team, @team2]
    result.expects(:teams).returns [@team, @team2]
    @team.results = [result]

    fixtures = @team.fixtures

    fixtures.should_not include SeasonFixture.new(@team2)
    fixtures.should include SeasonFixture.new(@team3)
    fixtures.should_not include SeasonFixture.new(@team)
  end
end