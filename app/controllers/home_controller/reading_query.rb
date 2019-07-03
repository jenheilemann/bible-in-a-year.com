class HomeController
  class ReadingQuery
    attr_reader :queryable

    def initialize(queryable = ::Reading)
      @queryable = queryable
    end

    def by_date(date)
      # repeat a week if it's a "leap" year
      if date.cweek == 53
        date = date + 7
      end
      zero_index_weekday = date.cwday - 1
      queryable.where(day: zero_index_weekday, week: date.cweek).first
    end

    def references_by_week
      queryable.all.order(:week, :day).select(:week, :day, :reference).group_by(&:week)
    end

  end
end
