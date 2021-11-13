require './keyable'
require './dateable'
require 'date'

module Encryptable
  include Keyable
  include Dateable

  def the_shift
    ("a".."z").to_a..push(" ")
  end

  def encrypt(message, key = random_key, date = default_date)


end
