class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  validates_presence_of :name
  validates_length_of :name, :within => 4..50,  :allow_blank => true

  def fixtures
    fixtures = Array.new

    season.teams.each { | team_in_season |
      fixtures << SeasonFixture.new(team_in_season) unless team_in_season == self
    }

    fixtures
  end

  def to_s
    "#{name}"
  end
end
