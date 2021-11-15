require './lib/enigma'

open_file = File.open(ARGV[0], "r")
message = open_file.read
open_file.close
enigma = Enigma.new
encrypted = enigma.encrypt((message.chomp))

writer = File.open(ARGV[1], "w")
#require "pry"; binding.pry
writer.write(encrypted[:encryption])

writer.close
