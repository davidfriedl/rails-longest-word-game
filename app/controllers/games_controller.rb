require 'open-uri'

class GamesController < ApplicationController
  def new
    # generate a random string of 10 letters in all caps
    input = ('A'..'Z').to_a
    @letters = ''
    10.times { @letters += input[rand(26)].to_s }
    @letters
  end

  def score
    # check if the word is a valid english word
    answer_array = params[:name].downcase.split('')
    letters_array = params[:letters].downcase.split('')

    if english_word(params[:name]) && word?(answer_array, letters_array)
      @result = "Congrats! #{params[:name]} is an English Word, and the word was computed using the grid."
    elsif english_word(params[:name]) == false && word?(answer_array, letters_array)
      @result = "Sorry, #{params[:name]} does not seem to be an English word! It was computed using the array though"
    elsif word?(answer_array, letters_array) == false
      @result = 'Word was not computed using the grid.'
    end
  end

  private

  def english_word(word)
    json_response = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)
    json_response['found']
  end

  def word?(answer, letters)
    answer.each do |letter|
      return false unless letters.include?(letter)

      letters.delete_at(letters.index(letter))
    end
    true
  end
end










