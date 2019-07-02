require 'test_helper'

class ReadingTest < ActiveSupport::TestCase

  def reading
    Reading.new
  end

  test "has a day" do
    assert_nil reading.day
  end
  test "has a week" do
    assert_nil reading.week
  end
  test "has a reference" do
    assert_nil reading.reference
  end
  test "has content" do
    assert_nil reading.content
  end
end
