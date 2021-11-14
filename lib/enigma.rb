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
              :date,
              :valid_chars

  def initialize
    @message    = ''
    @key        = ''
    @date       = ''
    @valid_chars = ('a'..'z').to_a.push(' ')
  end

  def key_maker
    random_key
  end

  def time_lord
    default_date
  end

  def encrypt(message, key = key_maker, date = time_lord)
    @message = message
    @key = key
    @date = date
  end
end
