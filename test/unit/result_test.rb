require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  fixtures :all

  def setup
    @forest = teams(:forest)
    @derby = teams(:derby)
    @forest.results.clear;@derby.results.clear
    assert_equal 0, @derby.results.length
    assert_equal 0, @forest.results.length
  end

  def test_my_setup_is_working_and_results_are_cleared
    assert_equal 0, @derby.results.length
    assert_equal 0, @forest.results.length
  end

  def deleting_result_propagates_accross
    result = Result.new
    result.add_score @derby, 5
    result.add_score @forest, 1
    result.save

    @forest.reload
    @derby.reload

    assert_equal 1, @derby.results.length
    assert_equal 1, @forest.results.length

    result.delete

    @forest.reload
    @derby.reload

    assert_equal 0, @derby.results.length
    assert_equal 0, @forest.results.length
  end

  def test_can_get_scores_from_result
    derby_score = Score.new({:score=>5, :team => @derby})
    forest_score = Score.new({:score=>1, :team => @forest})

    result = Result.new({:scores=>[derby_score, forest_score]})
    result.save

    assert_equal derby_score, @derby.reload.results.first.get_score(@derby)
    assert_equal forest_score, @forest.reload.results.first.get_score(@forest)
    assert_equal forest_score, result.get_opponent_score(@derby)
  end
end