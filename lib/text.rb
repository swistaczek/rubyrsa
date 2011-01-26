require 'lib/mathematics' 
class Text < Array
  include Mathematics
  def initialize(t)
    #@@chunk_size=$options.chunk_size
    @iv = LibTom::Math::Prime::random_of_size($options.chunk_size*3).to_s.to_i
    super(1,t)
  end

  def rotate
    self.reverse!
    push shift
  end

  def create_chunks!
    #self.replace(self[0].scan(/.{1,#{@@chunk_size}}/))
    self.replace(self[0].scan(/.{1,#{$options.chunk_size}}/))
  end

  #CRYPT METHODS

  def ecb_crypt!(key)
    self.create_chunks!
    self.each_index do |i|
      puts "plain_chunk: #{self[i]}"
      self[i]=self[i].to_i #dopisac metoda str2bignum
      self[i]=mod(self[i],key.e,key.n)
      puts "crypt_chunk: #{self[i]}"
    end
  end

  def cbc_crypt!(key)
    self.create_chunks!
    self << @iv
    self.take(self.length-1).each_index do |i|
      puts "plain_chunk: #{self[i]}"
      self[i] = self[i].to_i ^ self[i-1]
      self[i] = mod(self[i],key.e,key.n).to_s.to_i
      puts "crypt_chunk: #{self[i]}"
    end
  end

  def cfb_crypt!(key)
    self.create_chunks!
    self << @iv
    self.take(self.length-1).each_index do |i|
      puts "plain_chunk: #{self[i]}"
      self[i] = (mod(self[i-1],key.e,key.n) ^ self[i].to_i)
      puts "crypt_chunk: #{self[i]}"
    end
  end

  def ctr_crypt!(key)
    self.create_chunks!
    self.each_index do |i|
      ctr = (i+1)*2
      puts "plain_chunk: #{self[i]}"
      self[i] = (mod(ctr,key.e,key.n) ^ self[i].to_i)
      puts "crypt_chunk: #{self[i]}"
    end
  end

  #DECRYPT METHODS

  def ecb_decrypt!(key)
    self.each_index do |i|
      puts "crypt_chunk: #{self[i]}"
      self[i]=mod(self[i],key.d,key.n)
      puts "plain_chunk: #{self[i]}"
    end
    self.replace(self.join.to_a)
  end

  def cbc_decrypt!(key)
    self.rotate
    self.take(self.length-1).each_index do |i|
      puts "crypt_chunk: #{self[i]}"
      self[i] = mod(self[i],key.d,key.n)
      self[i] = self[i] ^ self[i+1]
      puts "plain_chunk: #{self[i]}"
    end
    self.reverse!.shift #usuwa iv
    self.replace(self.join.to_a)
  end

  def cfb_decrypt!(key)
    temp = Array.new
    self.take(self.length-1).each_index do |i|
      puts "crypt_chunk: #{self[i]}"
      temp << (mod(self[i-1],key.e,key.n) ^ self[i])
      puts "plain_chunk: #{temp[i]}"
    end
    #temp.reverse!
    self.replace(temp.join.to_a)
  end

  def ctr_decrypt!(key)
    self.each_index do |i|
      ctr = (i+1)*2
      puts "crypt_chunk: #{self[i]}"
      self[i] = (mod(ctr,key.e,key.n) ^ self[i])
      puts "plain_chunk: #{self[i]}"
    end
  end

end
