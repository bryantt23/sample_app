class Relationship < ActiveRecord::Base
  
  # Since destroying a user should also destroy that 
  # user’s relationships, we’ve added dependent: :destroy to the association
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
