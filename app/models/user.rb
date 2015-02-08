class User < ActiveRecord::Base
# if a user is destroyed, the user’s microposts should be destroyed as well  
  has_many :microposts, dependent: :destroy
  
  # This works because the microposts table has a user_id 
  # attribute to identify the user. An id used in this manner to 
  # connect two database tables is known as a foreign key
    has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
#   available via user.remember_token (for storage in the cookies)
# but does NOT store in database
  attr_accessor :remember_token, :activation_token, :reset_token
  
  # attr_accessor :remember_token, :activation_token
  # attr_accessor :remember_token
# As required by the virtual nature of the activation token, 
# we’ve added a second attr_accessor to our model

  before_save   :downcase_email
  before_create :create_activation_digest
  
  
  before_save { self.email = email.downcase }
  # before_save { email.downcase! }
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
  # validates :email, presence:   true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
# allow_blank: true to pass update tests  
  validates :password, length: { minimum: 6 }, allow_blank: true
  

#   http://stackoverflow.com/questions/12142374/railstutorial-org-chapter-6-unknown-attribute-password
 # attr_accessible :email, :name, :password, :password_confirmation
 # has_secure_password
  
  
#   copied from hartl's github
  # before_save { |user| user.email = user.email.downcase }
# 
  # validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    # uniqueness: { case_sensitive: false }
  # validates :password, length: { minimum: 6 }
  # validates :password_confirmation, presence: true
 

  # Returns the hash digest of the given string.
  def User.digest(string)
    
  # Using a high cost makes it computationally intractable to use 
  # the hash to determine the original password, 
  # which is an important security precaution in a 
  # production environment, but in tests we want the 
  # digest method to be as fast as possible. 
  
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    
#    can generate tokens for account activation and password reset links
    SecureRandom.urlsafe_base64
  end


=begin
without self the assignment would create a local variable called remember_token
But using self ensures that assignment sets the userâ€™s remember_token 
attribute
=end
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  # def authenticated?(remember_token)
  def authenticated?(attribute, token)
    
    # metaprogramming - send method, which lets us call a method with a 
    # name of our choice by “sending a message” to a given object    
    digest = send("#{attribute}_digest")
#     uses string interpolation
    
#     to pass test about user logging out in one browser but not 
# the other browser. i think it's because the password will now be nil
    return false if remember_digest.nil?
# return guarantees that the rest of method gets ignored if digest is nil
    
 # verify that a given remember token matches the user’s remember digest
    # BCrypt::Password.new(remember_digest).is_password?(remember_token)
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  # undoes user.remember by updating the remember digest with nil
  def forget
    update_attribute(:remember_digest, nil)
  end

# methods only used internally by the User model, 
# so not exposed to outside users

      # If the user is authenticated according to the booleans, 
      # we need to activate the user and update the activated_at timestamp
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end


  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
 
  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    
    # “Password reset sent earlier than two hours ago.”  
    reset_sent_at < 2.hours.ago
  end
    
  # Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
    
    # question mark ensures that id is properly escaped before 
    # being included in the underlying SQL query
    # Micropost.where("user_id = ?", id)
    
    # Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
    
#     now uses SQL
# pushing the finding of followed user ids into the database using a subselect
    # Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
                    # following_ids: following_ids, user_id: id)
                    

    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
                    
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  

    

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end