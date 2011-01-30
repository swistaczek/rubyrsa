require 'lib/mathematics'
class Key
  include Mathematics
  attr_reader :e, :d, :n, :fi
  def initialize
    if $options.gen_key == true
      p = 0
      q = 0
      while p == q # szukamy p != q
        p = LibTom::Math::Prime::random_of_size($options.bits, { :safe => true} )
        q = LibTom::Math::Prime::random_of_size($options.bits, { :safe => true} )
      end
      @n = p * q
      @fi = self.euler_func(p,q)
      @e = self.find_e(@fi)
      @d = self.find_d(@e,@fi)
    else
       File.open(".key.txt", "r") do |f|
         @e = f.gets.to_i
         @d = f.gets.to_i
         @fi = f.gets.to_i
         @n = f.gets.to_i
       end
    end
  end

  def write_key
    File.open(".key.txt", "w") do |f|
      f.puts self.e
      f.puts self.d
      f.puts self.fi
      f.puts self.n
    end
  end

end

