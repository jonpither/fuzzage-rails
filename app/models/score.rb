class Score < ActiveRecord::Base
  belongs_to :team
  belongs_to :result

  validates_numericality_of :score, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
end