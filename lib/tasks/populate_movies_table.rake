task :populate_movies_table => :environment do
  movie_file = "movies_top250.txt"
  error_file = "error_" + movie_file

  base_dir   = Rails.root + 'lib/assets/' 
  file_path  = base_dir + movie_file
  error_path = base_dir + error_file 

  fh = File.open(file_path)
  ef = File.open(error_path, "w")

  while (line = fh.gets) != nil
    line.chomp!
    line = line.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
    arr = line.split(',')
    # puts arr.inspect
    response = query_omdb(arr[0], arr[1])
    # puts response
    if response.include? "Error"
      ef.write "#{arr[0]}\n"
    else
      hash = JSON.parse response.body
      add_movie hash
    end
  end

  fh.close
  ef.close
end

def add_movie(params)
    movie = Movie.new
    movie.title       = params["Title"]
    movie.year        = params["Year"]
    movie.released    = params["Released"]
    movie.runtime     = params["Runtime"].split()[0]    # 130 min
    movie.plot        = params["Plot"]
    movie.awards      = params["Awards"]
    movie.poster      = params["Poster"]
    movie.metascore   = params["Metascore"]
    movie.imdb_rating = params["imdbRating"]
    movie.imdb_votes  = params["imdbVotes"].tr(',','')  # 1,2345 => 12345
    movie.imdb_id     = params["imdbID"]
    movie.rated_id    = add_rated(params["Rated"])

    if movie.save 
      puts "#{movie.title} added successfully!"
      add_genre(params["Genre"], movie)
      add_director(params["Director"], movie)
      add_actor(params["Actors"], movie)
    end
end

def add_actor(actors, movie)
  actors_arr = actors.split(',')
  actors_arr.each do |actor|
    actor.strip! # delete leading and tailing white spaces
    a = Actor.find_by(full_name: actor)
    if a.nil?
      # this actor doesnt exist in my database, add it
      a = Actor.create(full_name: actor)
    end
    a.actings.create(movie: movie) 
  end
end

def add_director(directors, movie)
  # genre is actually comma separated value
  # for example: Crime, Drama
  directors_arr = directors.split(',')
  directors_arr.each do |director|
    director.strip! # delete leading and tailing white spaces
    d = Director.find_by(full_name: director)
    if d.nil?
      # this director doesnt exist in my database, add it
      d = Director.create(full_name: director)
    end
    d.directings.create(movie: movie) 
  end
end

def add_genre(genre, movie)
  # genre is actually comma separated value
  # for example: Crime, Drama
  genre_arr = genre.split(',')
  genre_arr.each do |genre|
    genre.strip!
    g = Genre.find_by(genre: genre)
    if g.nil?
      # this genre doesnt exist in my database, add it
      g = Genre.create(genre: genre)
    end
    g.genremovies.create(movie: movie) 
  end
end

def add_rated(rated)
  @rated = Rated.find_by(rated: rated)
  if @rated.nil?
    @rated = Rated.create(rated: rated)
  end
  @rated.id
end

def query_omdb(movie, year)
    omdb_url = "http://www.omdbapi.com/"
    # example URL: http://www.omdbapi.com/?t=city+of+god&y=&plot=short&r=json
    options = { query:  { t: movie, y: year, plot: "full", r: "json"} }
    return HTTParty.get(omdb_url, options)
end

