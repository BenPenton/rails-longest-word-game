require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @grid = []
    10.times do
      @grid << ("A".."Z").to_a.sample
    end
  end

  def score
    dic_return = load_json(params["user_answer"])
    dic_check = dic_return["found"]
    split_attempt = params["user_answer"].upcase.split("")
    letter_check = split_attempt.all? { |letter| split_attempt.count(letter) <= params["grid"].split("").count(letter) }
    if letter_check && dic_check
      score = params["user_answer"].length * 100
      @message = "Congratulations you scored #{score}"
    elsif !dic_check && letter_check
      @message = "Your word is in the grid but not in the dictionary"
    elsif dic_check && !letter_check
      @message = "Your word is in the dictionary but not in the grid"
    else
      @message = "ENGLISH MOTHER FUCKER DO YOU SPEAK IT!!!!"
    end
  end

  def load_json(input)
    file_path = "https://wagon-dictionary.herokuapp.com/#{input}"
    json_file = open(file_path).read

    return JSON.parse(json_file)
  end
end
