#!/usr/bin/ruby

require 'rubygems'
require 'lib/options'
require 'lib/text'
require 'lib/key'

text = Text.new
key = Key.new
text.crypt!(key)
