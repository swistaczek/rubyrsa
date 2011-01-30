require 'rubygems'
require 'test/unit'

require 'lib/text'
require 'lib/key'
require 'lib/options'
class TestRubyRSA < Test::Unit::TestCase
  def setup
    @num ||= 100
    @key ||= Key.new
    @text ||= Array.new
    @tested ||= Array.new
  end

  def teardown
    @text.clear
    @tested.clear
  end
  
  def get_rand_str
    length = 10 + rand(90)
    str = (0..length).map{32.+(rand(94)).chr}.join
  end

  def test_ecb
    0.upto(@num-1) do |i|
      str = get_rand_str
      @text << Text.new(str)
      @tested << Text.new(str)
      @tested[i].ecb_crypt!(@key)
      @tested[i].ecb_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end
  
  def test_cbc
    0.upto(@num-1) do |i|
      str = get_rand_str
      @text << Text.new(str)
      @tested << Text.new(str)
      @tested[i].cbc_crypt!(@key)
      @tested[i].cbc_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end

  def test_cfb
    0.upto(@num-1) do |i|
      str = get_rand_str
      @text << Text.new(str)
      @tested << Text.new(str)
      @tested[i].cfb_crypt!(@key)
      @tested[i].cfb_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end

  def test_ctr
    0.upto(@num-1) do |i|
      str = get_rand_str
      @text << Text.new(str)
      @tested << Text.new(str)
      @tested[i].ctr_crypt!(@key)
      @tested[i].ctr_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end
end
