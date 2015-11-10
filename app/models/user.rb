class User < ActiveRecord::Base
  def self.from_omniauth(data)
    return false if !valid_data(data)
    user = find_or_create_by(uid: data.uid)
    update_user(user, data)
    user
  end

  def self.valid_data(data)
    (!data.uid || data.uid.nil?) ? false : true
  end

  def self.update_user(user, data)
    user.update_attributes(
      nickname: data.info.nickname,
      email: data.info.email,
      name: data.info.name,
      image: data.info.image,
      token: data.credentials.token
      )
  end

  enum role: %w(default admin)
end
