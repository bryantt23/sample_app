class User < ActiveRecord::Base
  
#   available via user.remember_token (for storage in the cookies)
# but does NOT store in database
  attr_accessor :remember_token
  
  before_save { self.email = email.downcase }
  # before_save { email.downcase! }
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 255 },
  # validates :email, presence:   true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  

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
  def authenticated?(remember_token)
    
 # verify that a given remember token matches the user’s remember digest
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end



end