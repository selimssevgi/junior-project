module MoviesHelper
  def get_genre_string(genres)
    arr = []
    genres.each do |genre|
      arr << genre.genre
    end

    return arr.join(', ')
  end

  def join_countries(countries)
    arr = []
    countries.each do |country|
      arr << country.country_name
    end

    return arr.join(', ')
  end
end
