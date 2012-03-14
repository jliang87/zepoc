module UsersHelper
  
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user)
    gravatar_url= "http://gravatar.com/avatar/#{gravatar_id}.png"
    image_tag(gravatar_url, alt:user, class:"gravatar")
  end
  
end
