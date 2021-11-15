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
    @message        = ''
    @key            = ''
    @date           = ''
    @encrypted_data = nil
    @decrypted_data = nil
  end

  def encrypt(message, key = random_key, date = default_date)
    @message = message
    @key     = key
    @date    = date
    shift = shift(@key, @date)
    puts "Created 'encrypted.txt' with the key #{@key} and date #{@date}"
    @encrypted_data = {encryption: cypher(@message, shift), key: @key, date: @date}
  end
  #require "pry"; binding.pry



  def decrypt(message, key = @encrypted_data[:key], date = @encrypted_data[:date])
    @message = message
    @key     = key
    @date    = date
    shift = shift(@key, @date)
    puts "Created 'decrypted.txt' with the key #{@key} and date #{@date}"
    @decrypted_data = {decryption: decypher(@message, shift), key: @key, date: @date}
  end
end
