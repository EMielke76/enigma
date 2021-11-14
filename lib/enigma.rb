require 'date'
require 'dateable'
require 'keyable'
require 'encryptable'

class Enigma
  include Dateable
  include Keyable
  include Encryptable
  attr_reader :message,
              :key,
              :date

  def initialize
    @message    = ''
    @key        = ''
    @date       = ''
  end

  def encrypt(message, key = random_key, date = default_date)
    @message = message
    @key = key
    @date = date
  end
end
