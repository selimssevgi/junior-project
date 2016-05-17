class User < ActiveRecord::Base
  has_many   :ratings 
  has_many   :rated_movies, through: :ratings, source: :movie

  has_many   :recommendations
  has_many   :recommended_movies, through: :recommendations, source: :movie

  has_many   :recommendeds
  has_many   :removed_recommended_movies, through: :recommendeds, source: :movie

  has_many   :watchlist_items, class_name:  "Watchlist",
                               foreign_key: "user_id",
                               dependent:   :destroy
  has_many   :movies_to_watch, through: :watchlist_items, source: :movie

  has_many   :watchedlist_items, class_name:  "Watchedlist",
                               foreign_key: "user_id",
                               dependent:   :destroy
  has_many   :watched_movies, through: :watchedlist_items, source: :movie

  has_many   :comments

  attr_accessor :remember_token
  before_save { email.downcase! }

  validates :name,  presence: true, length: { maximum: 50 }

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # allows usage of
  # two consecutive dots
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  # allow_nil is for test suits, has_secure method is checking 
  # for that while registering new users
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?  BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost 
    BCrypt::Password.create(string, cost: cost)
  end

  # returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def get_rate_for(movie)
    Rating.uncached do
      @rating = Rating.where(user_id: id, movie_id: movie.id).first
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # return true if the given token matches the digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end


end
