class User < ActiveRecord::Base
  
  
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




end