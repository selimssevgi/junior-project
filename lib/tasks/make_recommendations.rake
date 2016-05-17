task :make_recommendations => :environment do

  users = User.order(:email)
  len = users.length
  puts "There are #{len} users."

  for i in 0...len
    temp_user = users[i]
    puts "checking recommendations for user #{temp_user.id}"
    # calculate recommendations if there are less than 5
    if temp_user.recommended_movies.count < 5
      puts "there are less than 5 recs for user #{temp_user.id}"

      top_matches, sim_hash = get_top_matches_for(temp_user)
      possible_movies = get_possible_movies(temp_user, top_matches)

      possible_movies.each do |movie|
        puts "checking movie : ##{movie.id} #{movie.title}"
        guessed_rate = get_guessed_rate_for(movie, top_matches, sim_hash)
        # guess rate eger 5 den buyukse recommendation tablosuna ekle!
        if guessed_rate > 5
          # do not add multiple user id and movie id combinations
          # consider that is possible there may be change in the change
          recommendation = Recommendation.where("user_id = ? AND movie_id = ?", temp_user.id, movie.id).take
          recommendation = Recommendation.new if recommendation.nil?
          recommendation.user_id      = temp_user.id
          recommendation.movie_id     = movie.id
          recommendation.guessed_rate = guessed_rate 
          if recommendation.save
            puts "recommendation added successfully!"
          end
        end
      end
    end
  end
end

def get_guessed_rate_for(movie, top_matches, sim_hash)
  total = 0
  sim_total = 0

  top_matches.each do |matched_user|
    puts "checking user : #{matched_user.id}"
    rating = Rating.where("user_id = ? AND movie_id = ?", matched_user.id, movie.id).take
    unless rating.nil?
      # weight rating with similarity
      puts "rate of user for the movie is : #{rating.rate.to_f}"
      puts "similarity of the users : #{sim_hash[matched_user.id]}"
      total += rating.rate.to_f * sim_hash[matched_user.id]
      sim_total += sim_hash[matched_user.id]
    end
  end

  guessed_rate = total / sim_total 
  puts "Guessed rate for #{movie.title} is #{guessed_rate}"    

  return guessed_rate 
end

def get_possible_movies(user, top_matches)
  # there are movies that user has rated
  # and there are movies that users in top_matches have rated
  # we need to find all unique movies that have been rated by top matches
  # but not by the user
  possible_movies = []
  top_matches.each do |match|
    puts "User #{match.id} has #{match.rated_movies.count} movies"
    match.rated_movies.each do |movie|
      possible_movies << movie unless possible_movies.include? movie
    end
  end
  
  puts "movies user rated : #{user.rated_movies.count}"
  puts "possible movies count : #{possible_movies.length}"
  possible_movies = possible_movies - user.rated_movies 
  puts "possible movies count after op: #{possible_movies.length}"

  return possible_movies 
end

def get_top_matches_for(user)
  puts "getting matches for user #{user.id}"
  n = 5
  # take row with highest similarity
  most_similar_ones = UserSimilarity.where("fuser = ? OR suser = ?", user.id, user.id)
  most_similar_ones = most_similar_ones.order("similarity DESC").take(n)

  # find users most similar to given one
  top_matches = []
  sim_hash = {} # user id -> similarity with the given user
  most_similar_ones.each do |row|
    # puts "#{row.inspect}"
    if row.fuser != user.id
      user_id = row.fuser
    else
      user_id = row.suser
    end
    temp_user = User.find(user_id)
    unless temp_user.nil?
      sim_hash[user_id] = row.similarity 
      top_matches << temp_user
    end
  end
  
  return top_matches, sim_hash
end

# more practical if the sim_hash is used
def get_sim_of(fuser_id, suser_id)
  sim = UserSimilarity.where("fuser = ? OR suser = ?", fuser_id, suser_id)
  if sim.nil?
    sim = UserSimilarity.where("fuser = ? OR suser = ?", suser_id, fuser_id)
  end

  return sim
end
