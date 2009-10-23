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

  def wins?
    wins = 0
    results.each { |result| wins += 1 if result.get_score(self).greater_than(result.get_opponent_score(self)) }
    wins
  end

  def losses?
    losses = 0
    results.each { |result| losses += 1 if result.get_score(self).less_than(result.get_opponent_score(self)) }
    losses
  end

  def draws?
    draws = 0
    results.each { |result| draws += 1 if result.get_score(self).equal_to(result.get_opponent_score(self)) }
    draws
  end

  def played?
    results.length
  end

  def to_s
    "#{name}"
  end

end
