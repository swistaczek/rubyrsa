require 'lib/mathematics'
require 'lib/options'
class Text < Array
  include Mathematics
  def initialize(*args)
    @iv = LibTom::Math::Prime::random_of_size($options.chunk_size*3).to_s.to_i
    if args.size == 0 #new bez parametru - wczytujemy dane z pliku
      arr = Array.new
      str = ''
      if $options.infile == "stdin"
        $stdin.each_line do |line|
          if $options.direction == "de" #deszyfrujemy - nie mozemy polaczyc wszystkich linii w jednego stringa
            arr << line.to_i
          else
            str += line
          end
        end
      else
        File.open($options.infile, "r") do |file|
          file.each_line do |line|
            if $options.direction == "de"
              arr << line.to_i
            else
              str += line
            end
          end
        end
      end
      if $options.direction == "de"
        super(1,arr)
      else
        super(1,str)
      end
    else #new z parametrem - tekst podany jawnie
      super(1,args[0])
    end
  end

  def rotate
    self.reverse!
    push shift
  end

  def create_chunks!
    self.replace(self[0].scan(/[\s\S]{1,#{$options.chunk_size}}/))
  end

  def to_bignum(s)
    n = 0
    s.each_byte do |b|
      n = n * 256 + b
    end
    return n
  end

  def chunks_to_bignum!
    self.map! do |elem|
      to_bignum(elem)
    end
  end

  def to_string(n)
    s = ''
    while n > 0
      s = (n & 0xFF).to_s.to_i.chr + s
      n >>= 8
    end
    return s
  end

  def chunks_to_string!
    self.map! do |elem|
      to_string(elem)
    end
  end

  def to_output
    if $options.outfile == "stdout"
      puts self
    else
      File.open($options.outfile, "w") do |file|
        file.puts self
      end
    end
  end

  #CRYPT METHODS
  def crypt!(key)
    self.flatten!
    method = $options.mode.downcase + "_" + $options.direction + "crypt!"
    self.send(method, key)
    self.to_output
  end


  def ecb_crypt!(key)
    self.create_chunks!
    self.chunks_to_bignum!
    self.each_index do |i|
      self[i]=self[i]
      self[i]=mod(self[i],key.e,key.n)
    end
  end

  def cbc_crypt!(key)
    self.create_chunks!
    self.chunks_to_bignum!
    self << @iv
    self.take(self.length-1).each_index do |i|
      self[i] = self[i] ^ self[i-1]
      self[i] = mod(self[i],key.e,key.n).to_s.to_i
    end
  end

  def cfb_crypt!(key)
    self.create_chunks!
    self.chunks_to_bignum!
    self << @iv
    self.take(self.length-1).each_index do |i|
      self[i] = (mod(self[i-1],key.e,key.n) ^ self[i].to_i)
    end
  end

  def ctr_crypt!(key)
    self.create_chunks!
    self.chunks_to_bignum!
    self.each_index do |i|
      ctr = (i+1)*2
      self[i] = (mod(ctr,key.e,key.n) ^ self[i].to_i)
    end
  end

  #DECRYPT METHODS
  def ecb_decrypt!(key)
    self.each_index do |i|
      self[i]=mod(self[i],key.d,key.n)
    end
    self.chunks_to_string!
    self.replace(self.join.to_a)
  end

  def cbc_decrypt!(key)
    self.rotate
    self.take(self.length-1).each_index do |i|
      self[i] = mod(self[i],key.d,key.n)
      self[i] = self[i] ^ self[i+1]
    end
    self.reverse!.shift #usuwa iv
    self.chunks_to_string!
    self.replace(self.join.to_a)
  end

  def cfb_decrypt!(key)
    temp = Array.new
    self.take(self.length-1).each_index do |i|
      temp << (mod(self[i-1],key.e,key.n) ^ self[i])
    end
    #temp.reverse!
    self.replace(temp)
    self.chunks_to_string!
    self.replace(self.join.to_a)
  end

  def ctr_decrypt!(key)
    self.each_index do |i|
      ctr = (i+1)*2
      self[i] = (mod(ctr,key.e,key.n) ^ self[i])
    end
    self.chunks_to_string!
    self.replace(self.join.to_a)
  end

end

