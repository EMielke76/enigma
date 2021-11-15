require 'date'

module Dateable

  def default_date
    today = Date.today
    today.strftime("%d%m%y")
  end
end
