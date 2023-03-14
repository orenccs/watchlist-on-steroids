require "open-uri"
require "json"

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url2 = "https://api.themoviedb.org/3/list/634?api_key=faf4e2443a3935b78fc5c1d747520a64"
puts "Importing movies from page this list"
movies = JSON.parse(URI.open("#{url2}").read)['items']
movies.each do |movie|
  id = movie["id"]
  url3 = "https://api.themoviedb.org/3/movie/#{id}?api_key=faf4e2443a3935b78fc5c1d747520a64"
  details = JSON.parse(URI.open("#{url3}").read)
  puts "Creating #{details['title']}"
  base_poster_url = "https://image.tmdb.org/t/p/original"
  Movie.create(
    title: details["title"],
    overview: details["overview"],
    poster_url: "#{base_poster_url}#{details["backdrop_path"]}",
    rating: details["vote_average"]
  )
end
puts "Created #{Movie.count} movies"
