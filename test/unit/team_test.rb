require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @user = create_user
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
    assert_equal 'foo fighters', reloaded_team.name
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

  def test_no_games_played_fixtures
    forest = Team.new({:name => 'Nottingham Forest'})
    brighton = Team.new({:name => 'Brighton Hove Albion'})
    wolves = Team.new({:name => 'Brighton Hove Albion'})

    @season.teams << [forest, brighton]

    team = Team.new(:name => 'Derby County', :user => @user, :season => @season, :results => [])

    fixtures = team.fixtures
    assert fixtures.include?(SeasonFixture.new(forest))
    assert fixtures.include?(SeasonFixture.new(brighton))
    assert !fixtures.include?(SeasonFixture.new(wolves))
  end

  def test_has_played
    @season.save!
    forest = Team.new({:name => 'Nottingham Forest', :user => @user, :season => @season})
    brighton = Team.new({:name => 'Brighton Hove Albion', :user => @user, :season => @season})

    forest.save!
    brighton.save!

    assert !forest.has_played(brighton)
    assert !brighton.has_played(forest)

    result = Result.new
    result.add_score(brighton, 5)
    result.add_score(forest, 0)
    result.save!

    forest.reload
    brighton.reload

    assert forest.has_played(brighton)
    assert brighton.has_played(forest)
  end

  private

  def create_user
    return User.new({ 'name' => 'bastard', 'email' => 'foo@foo.com', 'password' =>'password', 'confirm_password' =>'password'})
  end
end
