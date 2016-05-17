task :update_recommended_table => :environment do
  recommended_entries = Recommended.all
  
  recommended_entries.each do |entry|
    rating = Rating.where("user_id = ? AND movie_id = ?", entry.user_id, entry.movie_id).take
    if !rating.nil?
      # user rated one of the recommended movies
      entry.real_rate = rating.rate
      entry.rated = 1
      if entry.save
        puts "updated..."
      end
    end
  end
end

