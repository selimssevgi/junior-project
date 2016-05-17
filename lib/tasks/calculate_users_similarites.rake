task :calculate_users_similarites => :environment do
  # find where you left
  # sims = MovieSimilarity.first

  # if sims
  #   puts sims.id
  # else
    start = 0
  # end

  # movies = Movie.all
  users = User.order(:email)
  len = users.length
  
  puts len
  for i in start..len-2
    fuser = users[i]
    for j in (i+1)...len # exclude the last value
      suser = users[j]
      # if row is older than a week/month calculate again
      user_similarity = UserSimilarity.where("fuser = ? AND suser = ?", fuser.id, suser.id).take
      # if sim.nil?
        puts "------"
        puts fuser.name + " and " + suser.name
        sim = get_similarities_of(fuser,suser)  
        puts "their similarity : #{sim}"
        # do not add if sim value is zero
        if sim != 0 
          user_similarity = UserSimilarity.new if user_similarity.nil?
          user_similarity.fuser     = fuser.id
          user_similarity.suser     = suser.id
          user_similarity.similarity = sim
          if user_similarity.save
            puts "users similarity saved to db successfully!"
          end
        end
      # end
    end
  end

end

def get_similarities_of(fuser, suser)
  sim = 0.0
  puts "fuser.id : #{fuser.id}, rated movie counts : #{fuser.rated_movies.count}"
  puts "suser.id : #{suser.id}, rated movie counts : #{suser.rated_movies.count}"
  sim = get_sim_distance(fuser,suser)
  puts "sim distance of two users : #{sim} "
  return sim
end

# returns a distance-based similarity score for fuser and suser
def get_sim_distance(fuser, suser)
  # get the list of common_rated_movies
  crm = []
  fuser.rated_movies.each do |movie|
    if suser.rated_movies.include?(movie)
      crm << movie
    end
  end

  # if they have no ratings in common, return 0
  return 0.0 if crm.length == 0

  # add up the squares of all the differences
  sum_of_squares = 0.0
  crm.each do |movie|
    puts "movie: #{movie.title}"
    frating = Rating.where("user_id = ? AND movie_id = ?", fuser.id, movie.id).take # take just one row
    frate   = frating.rate.to_f
    srating = Rating.where("user_id = ? AND movie_id = ?", suser.id, movie.id).take
    srate   = srating.rate.to_f
    puts "frate: #{frate} vs srate: #{srate}"
    puts "square diff : #{(frate-srate)**2}"
    sum_of_squares += (frate - srate) ** 2
  end

  puts "sum of squares : #{sum_of_squares}"
  return 1/(1+sum_of_squares)
end
