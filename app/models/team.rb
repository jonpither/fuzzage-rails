class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  has_many :scores, :dependent => :destroy
  has_many :results, :through => :scores

  validates_presence_of :name
  validates_length_of :name, :within => 4..50,  :allow_blank => true

  def fixtures
    fixtures = Array.new

    season.teams.each { | team |
      fixtures << SeasonFixture.new(team) unless (team == self || has_played(team))
    }

    fixtures
  end

  def has_played team
    results.each { |result| return true if result.teams.include?(team)}
    false
  end

  def to_s
    "#{name}"
  end

end
