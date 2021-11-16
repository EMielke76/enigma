require './lib/fileable'
include Fileable

file = File.open(ARGV[0], "r")
data = File.open(ARGV[1], "w")
encrypt(file, data)
