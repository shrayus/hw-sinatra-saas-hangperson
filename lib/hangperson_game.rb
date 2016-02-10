class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word
  
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError if (letter == nil or !letter.match(/[a-zA-Z]/))
    letter = letter.downcase
    return false if (@guesses.include? letter or @wrong_guesses.include? letter)
    (@word.include? letter) ? (@guesses << letter) : (@wrong_guesses << letter)
    return true
  end

  def check_win_or_lose
    if @word.split('').uniq.sort == @guesses.split('').uniq.sort
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    end
    return :play
  end
  
  def word_with_guesses
    to_return = ""
    @word.split("").each do |letter|
      to_return << ((@guesses.include? letter) ? letter : "-") 
    end
    return to_return
  end
  
end
