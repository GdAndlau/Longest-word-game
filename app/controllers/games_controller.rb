class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('a'..'z').to_a
    deck = alphabet.shuffle
    @letters = 8.times.map { deck.pop }
  end

  def score
    @word = params[:guess]
    @string = params[:letters]
    @answer = ""
    @final_score = 0
    @total_score = 0
    begin_time = Time.now;

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    test = JSON.parse(response)

    @included = @word.split("").all? { |letter| @string.include? letter }

    if test["found"]
      @answer = "this is a word"
      if @included
        @answer = "this is a word and included in the English language"
        end_time = Time.now; # why is this NIL?
        @total_time = end_time - begin_time
        @final_score = test["length"] - @total_time;
      else
        @answer = "the letters you used aren't the right ones"
      end
    else
      @answer = "this isn't a word"
    end
    raise
  end
end
