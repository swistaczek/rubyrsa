require 'optparse'
require 'ostruct'
require 'lib/key'
$options = OpenStruct.new
$options.bits = 64
$options.chunk_size = $options.bits/8
$options.gen_key = false
$options.mode = "cbc"
$options.direction = ""
$options.infile = "stdin"
$options.outfile = "stdout"

opts = OptionParser.new
opts.banner = "Użycie ./rubyrsa.rb [opcje]"
opts.summary_width= 30

opts.on("-h", "--help", "Wyświetla tekst pomocy") do
  puts opts.to_s
  exit(0)
end

opts.on("-b", "--bits BITS", "Ustawia liczbę bitów klucza na wartość BITS") do |bits|
  $options.bits = bits.to_i
  $options.chunk_size = $options.bits/8
end

opts.on("-n", "--gen-key", "Generuje pary kluczy i kończy działanie") do
  $options.gen_key = true
  key = Key.new
  key.write_key
  exit(0)
end

opts.on("-m", "--mode MODE", "Szyfruj w trybie MODE (domyślnie CBC)") do |mode|
  if mode !~ /(ecb)|(cbc)|(cfb)|(ctr)/i
    puts "Niepoprawny tryb szyfrowania. Obsługiwane tryby: ECB, CBC, CFB, CTR."
    exit(0)
  else
    $options.mode = mode
  end
end

opts.on("-d", "--decrypt", "Deszyfruj wiadomość (domyślnie szyfruj)") do
  $options.direction = "de"
end

opts.on("-i", "--input-file FILE", "Plik wejśćiowy") do |file|
  $options.infile = file
end

opts.on("-o", "--output-file FILE", "Plik wyjśćiowy") do |file|
  $options.outfile = file
end

opts.parse(ARGV)

