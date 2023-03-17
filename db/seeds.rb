require 'open-uri'
require 'json'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts 'Cleaning up database...'
Movie.destroy_all
puts 'Database cleaned'

BASE_URL = 'https://api.themoviedb.org/3'
API_KEY = ENV['TMDB_API_KEY']

# Fetch movies from a TMDb list
url = "#{BASE_URL}/list/634?api_key=#{API_KEY}"
puts 'Importing movies from list'
movies = JSON.parse(URI.open(url).read)['items']

# Loop through each movie and fetch its details, trailer, and credits
movies.each do |movie_data|
  # Fetch movie details
  url = "#{BASE_URL}/movie/#{movie_data['id']}?api_key=#{API_KEY}"
  details = JSON.parse(URI.open(url).read)
  pp details
  # Fetch movie trailer
  url = "#{BASE_URL}/movie/#{movie_data['id']}/videos?api_key=#{API_KEY}"
  trailers = JSON.parse(URI.open(url).read)['results']
  trailer = trailers.find { |trailer| trailer['type'] == 'Trailer' }
  trailer_key = trailer['key'] if trailer

  # Fetch movie credits
  url = "#{BASE_URL}/movie/#{movie_data['id']}/credits?api_key=#{API_KEY}"
  credits = JSON.parse(URI.open(url).read)
  actors = credits['cast'].map { |actor| actor['name'] }

  genres = details['genres'].map { |genre| genre['name'] }
  # Create Genres

  # Create movie object with details, trailer, and actors
  puts "Creating #{details['title']}"
  base_poster_url = 'https://image.tmdb.org/t/p/original'
  movie = Movie.create!(
    title: details['title'],
    overview: details['overview'],
    poster_url: "#{base_poster_url}#{details['backdrop_path']}",
    rating: details['vote_average'],
    # trailer_url: "https://www.youtube.com/watch?v=#{trailer_key}",
    actors: actors.join(', ')
  )

  genres.each do |genre|
    genre_movie = Genre.find_by_name(genre) || Genre.create(name: genre)
    GenreMovie.create(movie:, genre: genre_movie)
  end
end
