class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string "title"
      t.text "overview"
      t.string "poster_url"
      t.float "rating"
      t.string "actors"
      t.timestamps
    end

    create_table "genres"do |t|
      t.string "name"
      t.timestamps
    end

    create_table "genre_movies", force: :cascade do |t|
      t.references :movie, foreign_key: true
      t.references :genre, foreign_key: true
    end
  end
end
