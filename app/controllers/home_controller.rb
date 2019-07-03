class HomeController < ApplicationController
  def show(querier = ReadingQuery)
    now = Date.current
    @reading = querier.new.by_date(now)
    @references = querier.new.references_by_week
  end
end
