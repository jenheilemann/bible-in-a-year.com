require 'test_helper'
require 'csv'

class ReadingsImporterTest < ActiveSupport::TestCase

  def csv(record)
    CSV.parse("\"day\",\"week\",\"reference\",\"passage\"\n#{record}", headers: true)
  end

  def importer(record)
    ReadingsImporter.new(csv(record))
  end

  test "does things" do
    assert importer("").run
  end

  test "creates data" do
    assert_difference('Reading.count', 1) do
      importer('"1","1","Acts 1:1","I wrote the former account, Theophilus"').run
    end
    reading = Reading.where(day: 1, week: 1).first
    assert_equal "I wrote", "I wrote"
    assert_equal 'Acts 1:1', reading.reference
    assert_equal "I wrote the former account, Theophilus", reading.passage
  end

  test "overwrites existing data" do
    Reading.create(day: 2, week: 2, reference: "Blah", passage: "Words")
    assert_no_difference('Reading.count') do
      importer('"2","2","Acts 1:1","I wrote the former account, Theophilus"').run
    end
    search = Reading.where(day: 2, week: 2)
    assert_equal 1, search.length
    assert_equal "Acts 1:1", search.first.reference
    assert_equal "I wrote the former account, Theophilus", search.first.passage
  end
end
