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

  def offset_value(date)
    double_date = date.to_i ** 2
    double_date.to_s.slice(-4..-1)
  end

  def the_shift(offset, key)
    shift_values = []
    offset.each_char.with_index do |char, index|
      shift_values.push(char.to_i + key.slice(index..index+1).to_i)
    end
    shift_values
  end

  def cypher(message, shift)
    encrypted_message = ''
    down_boy = message.downcase
    down_boy.each_char do |char|
      if @valid_chars.include?(char) == false
        encrypted_message.concat(char)
      else
        new_char = @valid_chars.index(char) + shift[0]
        encrypted_message.concat(@valid_chars.rotate(new_char)[0])
        shift.rotate!
      end 
    end
    encrypted_message
  end

  def encrypt(message, key = key_maker, date = time_lord)
    @message = message
    @key = key
    @date = date
  end
end
