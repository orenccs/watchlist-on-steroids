require "httparty"

module TmdbApi
  BASE_URL = "https://api.themoviedb.org/3"
  API_KEY = ENV["9c09c4fbe0f65f4c1b13baf7884cdf42"]

  def self.search_movies(query)
    url = "#{BASE_URL}/search/movie?api_key=#{"9c09c4fbe0f65f4c1b13baf7884cdf42"}&query=#{query}"
    response = HTTParty.get(url)
    if response.code == 200
      response.parsed_response["results"]
    else
      []
    end
  end
end
