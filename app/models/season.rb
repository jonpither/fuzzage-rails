class Season < ActiveRecord::Base
  has_many :teams

  validates_presence_of :name
  validates_length_of :name, :within => 4..50

  def self.statuses
    ['open', 'closed']
  end
  
  def has_team? team
    teams.each { |other_team| return true if team == other_team}
    false
  end
end
