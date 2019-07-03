require 'test_helper'

class ReadingQueryTest < ActiveSupport::TestCase

  class QueryableDouble
    def self.where(day:, week:)
      if day == 0
        return ["Monday reading"]
      elsif day == 6
        return ["Sunday reading"]
      elsif day == 3 && week == 1
        return ["Leapweek reading"]
      end
    end
  end

  test "defaults to the Reading class as the queryable class" do
    querier = HomeController::ReadingQuery.new
    assert_equal ::Reading, querier.queryable
  end

  # Monday's Reading
  test "can find a reading for a Monday" do
    day = Date.parse('2020-08-24') # Monday of week 35 of the year
    query = HomeController::ReadingQuery.new(QueryableDouble).by_date(day)
    assert_equal "Monday reading", query
  end

  # Sunday's Reading
  test "can find a reading for a Sunday" do
    day = Date.parse('2020-08-30') # Sunday of week 35 of the year
    query = HomeController::ReadingQuery.new(QueryableDouble).by_date(day)
    assert_equal "Sunday reading", query
  end

  # Handles the 53rd week somehow
  test "doesn't die on a 'leap' year" do
    day = Date.parse('2020-12-31') # Thursday, week 53 of 2015
    query = HomeController::ReadingQuery.new(QueryableDouble).by_date(day)
    assert_equal "Leapweek reading", query
  end

end
