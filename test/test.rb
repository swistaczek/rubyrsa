require 'test/unit'
require 'rubygems'
require 'colorize'
require 'libtom/math'
require 'lib/text'
require 'lib/key'
require 'lib/options'

class TestRubyRSA < Test::Unit::TestCase
  @key = Key.new
  @text = 123456789
  @tested = Text.new(@text.to_s).ecb_crypt!(@key).ecb_decrypt!(@key)
  def test_rsa
    assert_equal(@text, @tested)
  end

end
