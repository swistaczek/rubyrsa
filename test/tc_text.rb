require 'rubygems'
require 'test/unit'

require 'lib/text'
require 'lib/key'
require 'lib/options'
class TestRubyRSA < Test::Unit::TestCase
  def setup
    @num ||= 5
    @range ||= 999_999_999_999_999
    @key ||= Key.new
    @text ||= Array.new
    @tested ||= Array.new
    @cbc_test ||= Array.new
  end

  def teardown
    @text.clear
    @tested.clear
  end

  def test_ecb
    0.upto(@num) do |i|
      str = rand(@range) + 1
      @text << Text.new(str.to_s)
      @tested << Text.new(str.to_s)
      @tested[i].ecb_crypt!(@key)
      @tested[i].ecb_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end
  
  def test_cbc
    0.upto(@num) do |i|
      str = rand(@range) + 1
      @text << Text.new(str.to_s)
      @tested << Text.new(str.to_s)
      @tested[i].cbc_crypt!(@key)
      @tested[i].cbc_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end

  def test_cfb
    0.upto(@num) do |i|
      str = rand(@range) + 1
      @text << Text.new(str.to_s)
      @tested << Text.new(str.to_s)
      @tested[i].cfb_crypt!(@key)
      @tested[i].cfb_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end

  def test_ctr
    0.upto(@num) do |i|
      str = rand(@range) + 1
      @text << Text.new(str.to_s)
      @tested << Text.new(str.to_s)
      @tested[i].ctr_crypt!(@key)
      @tested[i].ctr_decrypt!(@key)
      assert_equal(@text[i], @tested[i])
    end
  end
end
