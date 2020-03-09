require 'dotenv/load'
require_relative '../lib/api_request.rb'

RSpec.describe APIRequest do
  tmdb_api_key = APIRequest.instance_variable_get(:@tmdb_api_key)

  describe '#request_popular_movies' do
    it 'returns a string which is a link to a movie in themoviedb' do
      link = %r{https://www.themoviedb.org/movie/\d+}

      expect(APIRequest.request_popular_movies).to match link
    end

    it 'returns nil if an unexpected error occurs' do
      APIRequest.instance_variable_set(:@tmdb_api_key, 'asd')

      expect(APIRequest.request_popular_movies).to be_nil

      APIRequest.instance_variable_set(:@tmdb_api_key, tmdb_api_key)
    end
  end

  describe '#request_popular_shows' do
    it 'returns a string which is a link to a show in themoviedb' do
      link = %r{https://www.themoviedb.org/tv/\d+}

      expect(APIRequest.request_popular_shows).to match link
    end

    it 'returns nil if an unexpected error occurs' do
      APIRequest.instance_variable_set(:@tmdb_api_key, 'asd')

      expect(APIRequest.request_popular_shows).to be_nil

      APIRequest.instance_variable_set(:@tmdb_api_key, tmdb_api_key)
    end
  end

  describe '#request_movies_by_genre' do
    it 'returns a string which is a link to a movie in themoviedb' do
      link = %r{https://www.themoviedb.org/movie/\d+}

      expect(APIRequest.request_movies_by_genre(12)).to match link
    end

    it 'returns nil if an unexpected error occurs' do
      APIRequest.instance_variable_set(:@tmdb_api_key, 'asd')

      expect(APIRequest.request_movies_by_genre(12)).to be_nil

      APIRequest.instance_variable_set(:@tmdb_api_key, tmdb_api_key)
    end

    it 'returns nil if passed a wrong genre as argument' do
      expect(APIRequest.request_movies_by_genre(0)).to be_nil
    end
  end

  describe '#request_shows_by_genre' do
    it 'returns a string which is a link to a show in themoviedb' do
      link = %r{https://www.themoviedb.org/tv/\d+}

      expect(APIRequest.request_shows_by_genre(35)).to match link
    end

    it 'returns nil if an unexpected error occurs' do
      APIRequest.instance_variable_set(:@tmdb_api_key, 'asd')

      expect(APIRequest.request_shows_by_genre(35)).to be_nil

      APIRequest.instance_variable_set(:@tmdb_api_key, tmdb_api_key)
    end

    it 'returns nil if passed a wrong genre as argument' do
      expect(APIRequest.request_shows_by_genre(0)).to be_nil
    end
  end

  describe '#request_movie_genres' do
    it 'returns an object containing all the movie genres' do
      expect(APIRequest.request_movie_genres).to be_an Array
    end

    it 'returns nil if an unexpected error occurs' do
      APIRequest.instance_variable_set(:@tmdb_api_key, 'asd')

      expect(APIRequest.request_movie_genres).to be_nil

      APIRequest.instance_variable_set(:@tmdb_api_key, tmdb_api_key)
    end
  end

  describe '#request_show_genres' do
    it 'returns an object containing all the show genres' do
      expect(APIRequest.request_show_genres).to be_an Array
    end

    it 'returns nil if an unexpected error occurs' do
      APIRequest.instance_variable_set(:@tmdb_api_key, 'asd')

      expect(APIRequest.request_show_genres).to be_nil

      APIRequest.instance_variable_set(:@tmdb_api_key, tmdb_api_key)
    end
  end
end
