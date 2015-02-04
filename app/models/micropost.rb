class Micropost < ActiveRecord::Base
  belongs_to :user
  
   # “stabby lambda” syntax for an object called a Proc (procedure) or lambda, 
   # which is an anonymous function (a function created without a name). 
   # The stabby lambda -> takes in a block (Section 4.3.2) and returns a Proc, 
   # which can then be evaluated with the call method.   
  default_scope -> { order(created_at: :desc) }
  
  # tells CarrierWave to associate the image with a model 
  mount_uploader :picture, PictureUploader
  
   validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
