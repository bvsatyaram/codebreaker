module Codebreaker
  class Game
    def initialize(output)
      @output = output
    end

    def start(secret)
      @secret = secret
      @output.puts 'Welcome to Codebreaker!'
      @output.puts 'Enter guess:'
    end

    def guess(guess)
      raise 'Wrong lenght of guess' if guess.size != @secret.size

      @output.puts '+'*exact_match_count(guess) + '-'*number_match_count(guess)
    end

    private

    def exact_match_count(guess)
      (0..3).collect{|i| exact_match?(guess, i) ? 1 : 0}.reduce(:+)
    end

    def number_match_count(guess)
      @secret_hash = string_to_hash(@secret)
      (0..3).collect{|i| char_match?(guess, i) ? 1 : 0}.reduce(:+)
    end

    def exact_match?(guess, index)
      guess[index] == @secret[index]
    end

    def char_match?(guess, index)
      return false if exact_match?(guess, index)

      @secret_hash[guess[index]] ||= 0
      @secret_hash[guess[index]] -= 1
      return @secret_hash[guess[index]] >= 0
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
end