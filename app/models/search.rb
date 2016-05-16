class Search < ActiveRecord::Base
  def movies
    @movies ||= find_movies
  end

  private
    def find_movies
      movies = Movie.order(:title)

      if imdb_id.present?
        movies = movies.where(imdb_id: imdb_id)
        return movies
      end

      if genre_id.present?
        genre    = Genre.find(genre_id)       
        movies = genre.movies
      end

      if language_id.present?
        language = Language.find(language_id)       
        movies = language.movies
      end


      movies = movies.where("title like ?", "%#{title}%") if title.present?
      movies = movies.where("year >= ?", min_year) if min_year.present? and min_year > 1900
      movies = movies.where("year <= ?", max_year) if max_year.present? and max_year < 2017

      movies = movies.where("runtime >= ?", min_runtime) if min_runtime.present? and min_runtime > 60
      movies = movies.where("runtime <= ?", max_runtime) if max_runtime.present? and max_runtime < 250
      movies
    end
end
