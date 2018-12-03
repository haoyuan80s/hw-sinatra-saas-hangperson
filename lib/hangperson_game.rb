class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @guesses_count = 0
  end

  attr_accessor :word, :guesses, :wrong_guesses

  def guess(char)
    @guesses_count += 1
    unless char =~ /^[a-z]$/i
      raise ArgumentError
    end
    char.downcase!
    unless (@guesses + @wrong_guesses).include? char
      if @word.include? char
        # byebug
        @guesses= @guesses + char
      else
        @wrong_guesses= @wrong_guesses + char
      end
      true
    else
      false
    end
  end

  def word_with_guesses
    displayed_guesses = ''
    @word.each_char do |c|
      if guesses.include? c
        displayed_guesses += c
      else
        displayed_guesses += '-'
      end
    end
    displayed_guesses
  end

  def check_win_or_lose
    if @guesses_count >= 7
      :lose
    elsif word_with_guesses.include? '-'
      :play
    else
      :win
    end
  end
        
      

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end
