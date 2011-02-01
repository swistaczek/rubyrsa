require 'rubygems'
require 'test/unit'

require 'lib/key'
require 'lib/options'

class TestKey < Test::Unit::TestCase
  def setup
    @num = 1000
  end

  def teardown

  end

  def test_key
    1.upto(@num) do
      key = Key.new
      one = key.e * key.d % key.fi
      assert_equal(1, one)
    end
  end
end
