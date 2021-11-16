require 'date'
require_relative 'dateable'
require_relative 'keyable'
require_relative 'encryptable'

class Enigma
  include Dateable
  include Keyable
  include Encryptable
  attr_reader :message,
              :key,
              :date
  attr_accessor :encrypted_data,
                :decrypted_data

  def initialize
  end

  def encrypt(message, key = random_key, date = default_date)
    @message = message.downcase
    @key     = key
    @date    = date
    shift = shift(@key, @date)
    @encrypted_data = {encryption: cypher(@message, shift), key: @key, date: @date}
  end

  def decrypt(message, key = @encrypted_data[:key], date = @encrypted_data[:date])
    @message = message.downcase
    @key     = key
    @date    = date
    shift = shift(key, date)
    @decrypted_data = {decryption: decypher(@message, shift), key: @key, date: @date}
  end
end
