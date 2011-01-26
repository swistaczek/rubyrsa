module Mathematics
  def euler_func(p,q)
    return (p-1)*(q-1)
  end

  def mod(base, pow, mod)
    result = 1
    return result if pow == 0
    while pow > 0
      result = (result * base) % mod if pow & 1 == 1
      base = (base * base) % mod
      pow >>= 1
    end
    return result
  end

  def ext_euc(a,b)
    return [0,1] if a % b == 0
    x,y = ext_euc(b, a % b)
    [y, x-y*(a/b)]
  end

  def find_d(e,fi)
    x,y=ext_euc(e,fi)
    x += fi if x < 0
    x
  end
end

