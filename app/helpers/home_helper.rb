module HomeHelper
  def nice_date
    day = Date.current
    day.strftime("%A, %B %-d<sup>#{day.day.ordinal}</sup>, %Y").html_safe
  end

  def formatted_passage(passage)
    HomeController::Formatter.new(passage).format
  end

  def this_week?(week_number)
    date = Date.current
    date.cweek == week_number
  end

  def link_to_net_bible(reference)
    no_spaces = reference.gsub(/\s/, '+')
    link = "http://net.bible.org/bible/#{no_spaces}"
    link_to reference, link
  end
end

