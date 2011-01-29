#!/usr/bin/ruby

require 'rubygems'
require 'libtom/math'
require 'colorize'

require 'lib/options'
require 'lib/text'
require 'lib/key'

def puts_mode(mode)
  puts " #{mode} ".black.on_red
end

if $options.gen_key == true
  text = Text.new("123456789123456")
  puts text
  key = Key.new
  puts_mode "ECB"
  puts "plain: " + "#{text}".green
  text.ecb_crypt!(key)
  puts "encrypted: " + "#{text}".red
  text.ecb_decrypt!(key)
  puts "decrypted: " + "#{text}".green
  puts_mode "CBC"
  puts "plain: " + "#{text}".green
  text.cbc_crypt!(key)
  puts "encrypted: " + "#{text}".red
  text.cbc_decrypt!(key)
  puts "decrypted: " + "#{text}".green
  puts_mode "CFB"
  puts "plain: " + "#{text}".green
  text.cfb_crypt!(key)
  puts "encrypted: " + "#{text}".red
  text.cfb_decrypt!(key)
  puts "decrypted: " + "#{text}".green
  puts_mode "CTR"
  puts "plain: " + "#{text}".green
  text.ctr_crypt!(key)
  puts "encrypted: " + "#{text}".red
  text.ctr_decrypt!(key)
  puts "decrypted: " + "#{text}".green
end
