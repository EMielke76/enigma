require './keyable'
require './dateable'
require 'date'

class Abwehr
  include Keyable
  include Dateable
  attr_reader :message,
              :key,
              :date

  def initialize(message, key = random_key, date = default_date)
    @message = message
    @key     = key
    @date    = date
  end
end
