module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  # Returns the institution and grad year for a user (e.g University of Foobar '03)
  def institution_for(user)
    gradyear = user.gradyear.nil? ? '' : "#{gradyear_short(user.gradyear)}"
    user.institution.nil? ? '' : "#{user.institution.name} #{gradyear}"
  end

  def gradyear_short(gradyear)
    gradyear.nil? ? "" : "'#{gradyear.inspect[2..3]}"
  end
end
