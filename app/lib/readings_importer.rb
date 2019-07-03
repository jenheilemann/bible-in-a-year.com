
class ReadingsImporter
  attr_reader :table

  def initialize(table)
    @table = table
  end

  def run
    table.each do |row|
      begin
        Reading.create(
          day:       row['day'],
          week:      row['week'],
          reference: row['reference'],
          passage:   row['passage']
        )
      rescue ActiveRecord::RecordNotUnique
        existing = Reading.where(day: row['day'], week: row['week']).first
        if existing.reference != row['reference'] || existing.passage != row['passage']
          existing.update(reference: row['reference'], passage: row['passage'])
        end
      end
    end
  end

end
