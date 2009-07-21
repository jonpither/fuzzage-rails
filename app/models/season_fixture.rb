class SeasonFixture
  @team
  
  attr_accessor :team

  def initialize(team)
    @team = team
  end

  def == other
    team == other.team
  end
end