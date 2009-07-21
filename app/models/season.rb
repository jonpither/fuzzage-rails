class Season < ActiveRecord::Base
  has_many :teams

  validates_presence_of :name
  validates_length_of :name, :within => 4..50

  def self.statuses
    ['open', 'closed']
  end
end
