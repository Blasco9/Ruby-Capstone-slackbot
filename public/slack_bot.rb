require 'slack-ruby-bot'
require 'open-uri'
require 'json'

class Rubot < SlackRubyBot::Bot
  @tmdb_api_key = '23da466963844c59553f6bf355617531'

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
      movie = request_latest_movies
    else
      movie_genres = request_movie_genres

      if movie_genres.nil?
        movie = nil
      else
        movie_genres.each do |genre|
          movie = request_movies_by_genre(genre['id']) if expression.match(/#{genre['name']}/i)
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
      show = request_latest_shows
    else
      shows_genres = request_show_genres

      if shows_genres.nil?
        show = nil
      else
        expression.slice!(expression.index('&') + 1..11) if expression.index('&')

        shows_genres.each do |genre|
          show = request_shows_by_genre(genre['id']) if expression.match(/#{genre['name']}/i)
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

  def self.request_latest_movies
    begin
      response = JSON.parse(open("https://api.themoviedb.org/3/movie/popular?api_key=#{@tmdb_api_key}").read)
      movie = response['results'][rand(20)]
    rescue StandardError
      movie = nil
    end

    if movie.nil?
      nil
    else
      "https://www.themoviedb.org/movie/#{movie['id']}"
    end
  end

  def self.request_latest_shows
    begin
      response = JSON.parse(open("https://api.themoviedb.org/3/tv/popular?api_key=#{@tmdb_api_key}").read)
      show = response['results'][rand(20)]
    rescue StandardError
      show = nil
    end

    if show.nil?
      nil
    else
      "https://www.themoviedb.org/tv/#{show['id']}"
    end
  end

  def self.request_movies_by_genre(genre)
    begin
      response = JSON.parse(
        open("https://api.themoviedb.org/3/discover/movie?api_key=#{@tmdb_api_key}&with_genres=#{genre}").read
      )
      movie = response['results'][rand(20)]
    rescue StandardError
      movie = nil
    end

    if movie.nil?
      nil
    else
      "https://www.themoviedb.org/movie/#{movie['id']}"
    end
  end

  def self.request_shows_by_genre(genre)
    begin
      response = JSON.parse(
        open("https://api.themoviedb.org/3/discover/tv?api_key=#{@tmdb_api_key}&with_genres=#{genre}").read
      )
      show = response['results'][rand(20)]
    rescue StandardError
      show = nil
    end

    if show.nil?
      nil
    else
      "https://www.themoviedb.org/tv/#{show['id']}"
    end
  end

  def self.request_movie_genres
    response = JSON.parse(open("https://api.themoviedb.org/3/genre/movie/list?api_key=#{@tmdb_api_key}").read)
    response['genres']
  rescue StandardError
    nil
  end

  def self.request_show_genres
    response = JSON.parse(open("https://api.themoviedb.org/3/genre/tv/list?api_key=#{@tmdb_api_key}").read)
    response['genres']
  rescue StandardError
    nil
  end
end

Rubot.run
