module MoviesHelper
  def get_genre_string(genres)
    arr = []
    genres.each do |genre|
      arr << genre.genre
    end

    return arr.join(', ')
  end
end
