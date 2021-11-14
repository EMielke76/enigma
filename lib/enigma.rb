require 'date'
require 'dateable'
require 'keyable'

class Enigma
  include Dateable
  include Keyable
  attr_reader :message,
              :key,
              :date,
              :char_array

  def initialize
    @message    = ""
    @key        = ""
    @date       = ""
    @char_array = ('a'..'z').to_a.push(' ')
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
    #require "pry"; binding.pry
    shift_values
  end
end
