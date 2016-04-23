task :calculate_movies_similarites => :environment do
  # find where you left
  sims = MovieSimilarity.first

  if sims
    puts sims.id
  else
    start = 0
  end

  # movies = Movie.all
  movies = Movie.order(:title)
  len = movies.length
  
  puts len
  for i in start..len-2
    fmovie = movies[i]
    for j in (i+1)...len # exclude the last value
      smovie = movies[j]
      puts "------"
      puts fmovie.title + " and " + smovie.title
      sim = get_similarities_of(fmovie,smovie)  
      puts "their similarity : #{sim}"
      movie_similarity = MovieSimilarity.new
      movie_similarity.fmovie     = fmovie.id
      movie_similarity.smovie     = smovie.id
      movie_similarity.similarity = sim
      if movie_similarity.save
        puts "Movies similarity saved to db successfully!"
      end
    end
  end

end

def get_similarities_of(fmovie, smovie)
  sim = 0.0
  sim += get_title_similarity(fmovie, smovie)
  sim += get_year_similarity(fmovie, smovie)
  sim += get_runtime_similarity(fmovie, smovie)
  sim += get_irating_similarity(fmovie, smovie)
  sim += get_locality_similarity(fmovie, smovie)
  sim += get_people_similarity(fmovie, smovie)
  sim += get_genre_similarity(fmovie, smovie)

  return sim
end

def get_title_similarity(fmovie, smovie)
  # if is sequence movie, is highly similar
  # sequence movies will have at least more than 8 same letters
  if fmovie.title.downcase.split('').to_a[0,8] == smovie.title.downcase.split('').to_a[0,8] 
    puts fmovie.title + " and " + smovie.title + " are same! "
    return 5.0;
  end
  return 0.0;
end

def get_year_similarity(fmovie, smovie)
  # movies in the same year might similar. 2
  diff = (fmovie.year - smovie.year).abs
  puts "year difference : #{diff}"
  # movies in the databases has 100 years diff max
  sim = 2.0 - diff / 50.0
  puts "year similarity: #{sim}"
  return sim
  # return 0.0 if diff > 10
  # return 1.0 if diff < 6
  # return 0.5 # is between 5 and 10
end

def get_runtime_similarity(fmovie, smovie)
  # movies with closer runtime might be similar. 1
  diff = (fmovie.runtime - smovie.runtime).abs
  puts "runtime difference : #{diff}"
  # max runtime diff 300
  sim =  1.0 - diff / 300.0
  puts "runtime similarity: #{sim}"
  return sim
  # return 0.0 if diff > 40
  # return 1.0 if diff < 20
  # return 0.5 # is between 5 and 10
end

def get_irating_similarity(fmovie, smovie)
  # movies with less than 2 diff of irating might be similar 1.0
  diff = (fmovie.imdb_rating - smovie.imdb_rating).abs
  puts "imdb_rating difference : #{diff}"
  return 1.0 if diff < 2
  return 0.0
end

def get_locality_similarity(fmovie, smovie)
  # movies from same country, same languages might be similar
  temp_sum = 0.0 
  fmovie.countries.each do |country|
    if smovie.countries.include? country
      temp_sum += 0.5
      break
    end
  end

  fmovie.languages.each do |language|
    if smovie.languages.include? language
      temp_sum += 0.5
      break
    end
  end
  
  puts "locality similarity : #{temp_sum}"
  return temp_sum 
end

def get_people_similarity(fmovie, smovie)
  # movies from same director, same writer or actors  might be similar
  temp_sum = 0.0 
  fmovie.directors.each do |director|
    if smovie.directors.include? director
      temp_sum += 0.75
    end
  end

  fmovie.writers.each do |writer|
    if smovie.writers.include? writer
      temp_sum += 0.5
    end
  end
  
  fmovie.actors.each do |actor|
    if smovie.actors.include? actor
      temp_sum += 0.5
    end
  end

  puts "people similarity : #{temp_sum}"
  return temp_sum 
end

def get_genre_similarity(fmovie, smovie)
  # movies with same gender might be similar
  temp_sum = 0.0
  fmovie.genres.each do |genre|
    if smovie.genres.include? genre
      temp_sum += 1.0
    end
  end
  puts "genre similarity: #{temp_sum}"
  return temp_sum
end
