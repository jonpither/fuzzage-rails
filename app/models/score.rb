class Score < ActiveRecord::Base
  belongs_to :team
  belongs_to :result

  validates_numericality_of :score, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99

  def greater_than(other_score)
    return score > other_score.score;
  end

  def less_than(other_score)
    return score < other_score.score;
  end

  def equal_to(other_score)
    return score == other_score.score;
  end


end