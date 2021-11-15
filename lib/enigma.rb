require 'date'
require_relative 'dateable'
require_relative 'keyable'
require_relative 'encryptable'
require_relative 'fileable'

class Enigma
  include Dateable
  include Keyable
  include Encryptable
  include Fileable
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
    offset = offset_value(@date)
    shift = the_shift(offset, @key)
    puts "Created 'encrypted.txt' with the key #{@key} and date #{@date}"
    encrytped_hash = {encryption: cypher(@message, shift), key: @key, date: @date}
  end

end
