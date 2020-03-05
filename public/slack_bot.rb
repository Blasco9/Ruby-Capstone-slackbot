require 'slack-ruby-bot'
require 'open-uri'
require 'json'

class Rubot < SlackRubyBot::Bot
  @tmdb_api_key = '23da466963844c59553f6bf355617531'

  command 'recommend me a movie' do |client, data, match|
    expression = match[:expression]
    if expression.nil?
      movie = request_latest_movies
      client.say(text: "Here is your movie #{movie}\n", channel: data.channel)
    else
      movie_genres = request_movie_genres
      
      movie_genres.each do |genre|
        if expression.capitalize.match(genre['name'])
          movie = request_movies_by_genre(genre['id'])
        end
      end

      client.say(text: "Here is your movie #{movie}\n", channel: data.channel)
    end
  end

  command 'recommend me a show' do |client, data, match|
    expression = match[:expression]
    if expression.nil?
      show = request_latest_shows
      client.say(text: "Here is your show #{show}\n", channel: data.channel)
    else
      shows_genres = request_show_genres
      
      shows_genres.each do |genre|
        if expression.capitalize.match(genre['name'])
          show = request_shows_by_genre(genre['id'])
        end
      end

      client.say(text: "Here is your show #{show}\n", channel: data.channel)
    end
  end

  def self.request_latest_movies
    response = JSON.parse(open("https://api.themoviedb.org/3/movie/popular?api_key=#{@tmdb_api_key}").read)

    movie = response['results'][rand(20)]

    "https://www.themoviedb.org/movie/#{movie['id']}"
  end

  def self.request_latest_shows
    response = JSON.parse(open("https://api.themoviedb.org/3/tv/popular?api_key=#{@tmdb_api_key}").read)

    show = response['results'][rand(20)]

    "https://www.themoviedb.org/tv/#{show['id']}"
  end

  def self.request_movies_by_genre(genre)
    response = JSON.parse(open("https://api.themoviedb.org/3/discover/movie?api_key=#{@tmdb_api_key}&with_genres=#{genre}").read)

    movie = response['results'][rand(20)]

    "https://www.themoviedb.org/movie/#{movie['id']}"
  end

  def self.request_shows_by_genre(genre)
    response = JSON.parse(open("https://api.themoviedb.org/3/discover/tv?api_key=#{@tmdb_api_key}&with_genres=#{genre}").read)

    show = response['results'][rand(20)]

    "https://www.themoviedb.org/tv/#{show['id']}"
  end

  def self.request_movie_genres
    response = JSON.parse(open("https://api.themoviedb.org/3/genre/movie/list?api_key=#{@tmdb_api_key}").read)

    response['genres']
  end
  
  def self.request_show_genres
    response = JSON.parse(open("https://api.themoviedb.org/3/genre/tv/list?api_key=#{@tmdb_api_key}").read)

    response['genres']
  end
  puts "-------------------------------------------------------------------------------------------------------"

end

Rubot.run