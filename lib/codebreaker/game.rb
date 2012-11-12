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

      position_match_count = 0
      number_match_count = 0
      guess_hash = string_to_hash(guess)
      secret_hash = string_to_hash(@secret)
      guess_hash.keys.each do |char|
        position_match_count += (array_value_of_key_in_hash(guess_hash, char) & array_value_of_key_in_hash(secret_hash, char)).size
        number_match_count += [array_value_of_key_in_hash(guess_hash, char).size, array_value_of_key_in_hash(secret_hash, char).size].min
      end

      mark = ''
      mark << ('+' * position_match_count)
      mark << ('-' * (number_match_count - position_match_count))

      @output.puts mark
    end

    private

    def string_to_hash(str)
      hsh = {}
      str.split('').each_with_index do |char, i|
        hsh[char] ||= []
        hsh[char] <<   i
      end

      return hsh
    end

    def array_value_of_key_in_hash(hsh, key)
      hsh[key] || []
    end
  end
end