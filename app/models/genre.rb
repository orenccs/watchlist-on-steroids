class Genre < ApplicationRecord
  require_relative "../models/genre"
  has_many :genre_movies
  has_many :movies, through: :genre_movies
end
