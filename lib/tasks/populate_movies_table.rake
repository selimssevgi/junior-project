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

    if movie.save 
      puts "#{movie.title} added successfully!"
    end
end

def query_omdb(movie, year)
    omdb_url = "http://www.omdbapi.com/"
    # example URL: http://www.omdbapi.com/?t=city+of+god&y=&plot=short&r=json
    options = { query:  { t: movie, y: year, plot: "full", r: "json"} }
    return HTTParty.get(omdb_url, options)
end

