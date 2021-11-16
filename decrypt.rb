require './lib/fileable'
include Fileable

file = File.open(ARGV[0], "r")
data = File.open(ARGV[1], "w")
key  = ARGV[2]
date = ARGV[3]

guardhouse(file, data, key, date)
