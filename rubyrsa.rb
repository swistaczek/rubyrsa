#!/usr/bin/ruby

require 'rubygems'
require 'colorize'
require 'lib/options'
require 'lib/text'
require 'lib/key'

def puts_mode(mode)
  puts " #{mode} ".black.on_red
end

  text = Text.new("abc defg hijklmnop   qrstu wxyz")
  key = Key.new
  puts_mode "#{$options.mode.upcase}"
  puts "plain: " + "#{text}".green
  text.crypt!(key)
  puts "encrypted: " + "#{text}".red
  text.decrypt!(key)
  puts "decrypted: " + "#{text}".green

