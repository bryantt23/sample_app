module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    
    # Since email addresses are case-insensitive (Section 6.2.4) but 
      # MD5 hashes are not, we’ve used the downcase method to ensure 
      # that the argument to hexdigest is all lower-case.
     
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end