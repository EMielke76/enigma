require 'date'

module Encryptable
  def valid_chars
    ('a'..'z').to_a.push(' ')
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

  def shift(key, date)
    offset = offset_value(date)
    shift = the_shift(offset, key)
  end

  def cypher(message, shift)
    encrypted_message = ''
    down_boy = message.downcase
    down_boy.each_char do |char|
      if valid_chars.include?(char) == false
        encrypted_message.concat(char)
      else
        new_char = valid_chars.index(char) + shift[0]
        encrypted_message.concat(valid_chars.rotate(new_char)[0])
        shift.rotate!
      end
    end
    encrypted_message
  end

  def decypher(message, un_shift)
    decrypted_message = ''
    down_boy= message.downcase
    down_boy.each_char do |char|
      if valid_chars.include?(char) == false
        decrypted_message.concat(char)
      else
        char_index    = valid_chars.index(char)
        set_the_wheel = valid_chars.rotate(char_index)
        decrypted_message.concat(set_the_wheel.rotate((un_shift[0] * -1))[0])
        un_shift.rotate!
      end
    end
    decrypted_message
  end
end
