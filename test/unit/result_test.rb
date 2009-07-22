require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  fixtures :all
  
  def test_should_be_able_save_result
    forest = teams(:forest)
    derby = teams(:derby)

    result = Result.new({:home_team => derby, :away_team => forest, :home_score=>5, :away_score=>1})
    result.save
  end
end