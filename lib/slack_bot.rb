require 'slack-ruby-bot'
require_relative 'api_request.rb'

class Rubot < SlackRubyBot::Bot
  help do
    title 'Rubot'
    desc 'This bot recommends movies and shows for you to watch.'

    command 'recommend me a movie' do
      desc 'Recommends a popular movie to watch. You can specify the genre of the movie'
      long_desc "After the command add a space and one of the following words:\n\n" \
      "Action,  Adventure,  Animation,  Comedy,  Crime,  Documentary,  Drama,  Family,  Fantasy,  History,\n" \
      'Horror,  Music,  Mystery,  Romance,  Science Fiction,  TV Movie,  Thriller,  War,  Western'
    end

    command 'recommend me a show' do
      desc 'Recommends a popular show to watch. You can specify the genre of the show'
      long_desc "After the command add a space and one of the following words:\n\n" \
      "Action & Adventure,  Animation,  Comedy,  Crime,  Documentary,  Drama,  Family,  Kids,\n" \
      'Mystery,  News,  Reality,  Sci-Fi & Fantasy,  Soap,  Talk,  War & Politics,  Western'
    end
  end

  command 'recommend me a movie' do |client, data, match|
    expression = match[:expression]
    if expression.nil?
      movie = APIRequest.request_popular_movies
    else
      movie_genres = APIRequest.request_movie_genres

      if movie_genres.nil?
        movie = nil
      else
        movie_genres.each do |genre|
          movie = APIRequest.request_movies_by_genre(genre['id']) if expression.match(/#{genre['name']}/i)
        end
      end
    end

    if movie.nil?
      client.say(text: "Sory I couldn\'t find what you were looking for.\n" \
      "Type 'help recommend me a movie' to see the genres available", channel: data.channel)
    else
      client.say(text: "Here is your movie #{movie}\n", channel: data.channel)
    end
  end

  command 'recommend me a show' do |client, data, match|
    expression = match[:expression]
    if expression.nil?
      show = APIRequest.request_popular_shows
    else
      shows_genres = APIRequest.request_show_genres

      if shows_genres.nil?
        show = nil
      else
        expression.slice!(expression.index('&') + 1..11) if expression.index('&')

        shows_genres.each do |genre|
          show = APIRequest.request_shows_by_genre(genre['id']) if expression.match(/#{genre['name']}/i)
        end
      end
    end

    if show.nil?
      client.say(text: "Sory I couldn\'t find what you were looking for.\n" \
      "Type 'help recommend me a show' to see the genres available", channel: data.channel)
    else
      client.say(text: "Here is your show #{show}\n", channel: data.channel)
    end
  end
end
