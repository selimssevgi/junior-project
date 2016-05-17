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

  def join_genres(genres)
    arr = []
    genres.each do |genre|
      arr << genre.genre
    end

    return arr.join(', ')
  end

  def convert_min(min)
    return "0" if min == 0
    hour = min / 60
    minute = min % 60

    return "#{hour}h #{minute}m"
  end
end
