# frozen_string_literal: true

module UsersHelper
  def gravatar_for user, size: Settings.size
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def delete_user? user
    current_user.admin? && !current_user?(user)
  end
end
