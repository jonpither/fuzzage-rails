class Result < ActiveRecord::Base
  has_many :scores, :dependent => :destroy
  has_many :teams, :through => :scores

  def add_score team, amount
    scores << Score.new({:score=>amount, :team => team})
  end

  def get_opponent_score team
    scores.each {|score|
      return score if team != score.team;
    }
  end

  def get_score team
    scores.each do |score|      
      return score if team == score.team;
    end
  end
end