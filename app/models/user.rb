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

  
end