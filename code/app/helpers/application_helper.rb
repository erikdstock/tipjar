module ApplicationHelper
  def format_month_year(time)
    time.strftime "%B %Y"
  end
end
