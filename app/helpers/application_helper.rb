module ApplicationHelper

  def copyright(start_year)
    this_year = Time.current.year.to_s
    "&copy;#{start_year}&#8211;#{this_year}".html_safe
  end
end
