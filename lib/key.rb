require 'lib/mathematics'
class Key
  include Mathematics
  attr_reader :e, :d, :n, :fi
  def initialize
    p = 0
    q = 0
    while p == q # szukamy p != q
      p = LibTom::Math::Prime::random_of_size($options.bits, { :safe => true} )
      q = LibTom::Math::Prime::random_of_size($options.bits, { :safe => true} )
    end
    @n = p * q
    @fi = self.euler_func(p,q)
    # @e = 65537
    @e = self.find_e(@fi)
    @d = self.find_d(@e,@fi)
  end
end

