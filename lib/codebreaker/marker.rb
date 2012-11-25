class Marker
  def initialize(secret, guess)
    @secret, @guess = secret, guess
  end

  def exact_match_count
    (0...(@guess.length)).collect{|i| exact_match?(i) ? 1 : 0}.reduce(:+)
  end

  def number_match_count
    @secret_hash = string_to_hash(@secret)
    (0...(@guess.length)).collect{|i| char_match?(i) ? 1 : 0}.reduce(:+)
  end

  private

  def exact_match?(index)
    @guess[index] == @secret[index]
  end

  def char_match?(index)
    return false if exact_match?(index)

    @secret_hash[@guess[index]] ||= 0
    @secret_hash[@guess[index]] -= 1
    return @secret_hash[@guess[index]] >= 0
  end

  def string_to_hash(str)
    hsh = {}
    str.split('').each do |char|
      hsh[char] ||= 0
      hsh[char] += 1
    end

    return hsh
  end
end