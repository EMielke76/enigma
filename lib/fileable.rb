require_relative 'enigma'

module Fileable

  def guardhouse(file, data, key, date)
    if key.length == 5 && date.length == 6
      decrypt(file, data, key, date)
    else
      puts "The data you've supplied is insufficient. Please try again."
    end
  end

  def encrypt(file, data)
    message = file.read
    file.close
    enigma = Enigma.new
    encrypted = enigma.encrypt((message.chomp))
    data.write(encrypted[:encryption])
    data.close
  end

  def decrypt(file, data, key, date)
    message = file.read
    file.close
    enigma = Enigma.new
    decrypted = enigma.decrypt((message.chomp), key, date)
    data.write(decrypted[:decryption])
    data.close
  end
end
