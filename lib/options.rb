require 'optparse'
require 'ostruct'
$options = OpenStruct.new
$options.bits = 64
$options.chunk_size = $options.bits/8
$options.gen_key = true

opts = OptionParser.new
opts.banner = "Użycie ./rubyrsa.rb [opcje]"
opts.summary_width= 30

opts.on("-h", "--help", "Wyświetla tekst pomocy")do
  puts opts.to_s
  exit(0)
end

opts.on("-b", "--bits BITS", "Ustawia liczbę bitów klucza na wartość BITS") do |bits|
  $options.bits = bits.to_i
  $options.chunk_size = $options.bits/8
end

opts.on("-n", "--no-gen-key", "Nie generuje pary kluczy") do
  $options.gen_key = false
end

opts.parse(ARGV)

