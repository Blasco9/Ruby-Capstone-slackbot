require 'open-uri'
require 'json'

class APIRequest
  @tmdb_api_key = ENV['TMDB_API_KEY']

  def self.request_popular_movies
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

  def self.request_popular_shows
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
