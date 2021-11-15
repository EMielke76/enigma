require './lib/enigma'

open_file = File.open(ARGV[0], "r")
message = open_file.read
open_file.close
enigma = Enigma.new
enigma.encrypt((message.chomp))
