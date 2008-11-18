require File.dirname(__FILE__) + '/../test_helper'

class SeasonTest < ActiveSupport::TestCase
  def test_should_create_season
    season = Season.new({:name => '2008'})
    season.save
    assert !season.new_record?, "#{season.errors.full_messages.to_sentence}"
  end

  def test_errors_on_name
    season = Season.new({:name => nil})
    season.save
    assert season.errors.on(:name)
  end

  def test_length_of_name_minimum
    season = Season.new({:name => '123'})
    season.save
    assert season.errors.on(:name)
  end

  def test_length_of_name_maximum
    season = Season.new({:name => '123456789012345678901234567890123456789012345678901'})
    season.save
    assert season.errors.on(:name)
  end
end