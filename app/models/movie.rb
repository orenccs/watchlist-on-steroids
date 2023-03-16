class Movie < ApplicationRecord
  has_many :genre_movies, dependent: :destroy
  has_many :genres, through: :genre_movies, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true

  scope :by_genre, ->(genre_name) { joins(:genre_movies, :genres).where(genres: { name: genre_name }) }
  scope :by_release_year, ->(year) { where("release_date LIKE ?", "#{year}%") }
  scope :by_keywords, ->(keywords) { where("title LIKE ?", "%#{keywords}%") }
  scope :sorted_by, ->(sort_by) {
          case sort_by
          when "title_asc"
            order(title: :asc)
          when "title_desc"
            order(title: :desc)
          when "release_date_asc"
            order(release_date: :asc)
          when "release_date_desc"
            order(release_date: :desc)
          when "rating_desc"
            order(rating: :desc)
          when "rating_asc"
            order(rating: :asc)
          else
            order(title: :asc)
          end
        }
end
