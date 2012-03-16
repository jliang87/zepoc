module UsersHelper
  
  def gravatar_for(user, options = { size: 50})
    gravatar_id = Digest::MD5::hexdigest(user)
    size = options[:size]
    gravatar_url= "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt:user, class:"gravatar")
  end
  
end
