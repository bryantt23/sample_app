class Micropost < ActiveRecord::Base
  
  # This works because the microposts table has a user_id 
  # attribute to identify the user. An id used in this manner to 
  # connect two database tables is known as a foreign key
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
  
  # file size validation requires defining a custom validation
  validate  :picture_size


  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        
        # custom error message
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
