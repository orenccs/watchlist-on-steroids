class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = case params[:sort_by]
      when "title_asc"
        @movies.order(title: :asc)
      when "title_desc"
        @movies.order(title: :desc)
      when "release_date_asc"
        @movies.order(release_date: :asc)
      when "release_date_desc"
        @movies.order(release_date: :desc)
      when "rating_desc"
        @movies.order(rating: :desc)
      when "rating_asc"
        @movies.order(rating: :asc)
      else
        @movies.order(title: :asc)
      end
    if params[:keywords].present?
      @movies = @movies.where("title LIKE ? OR overview LIKE ?", "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    end
    @movies = @movies.where("release_date LIKE ?", "#{params[:release_year]}%") if params[:release_year].present?

    @movies = @movies.by_genre(params[:genre]) if params[:genre].present?

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    @movies = Movie.where("title LIKE ?", "%#{params[:query]}%")
    render partial: "search_results"
  end
end
