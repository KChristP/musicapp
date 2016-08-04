class User < ActiveRecord::Base

  attr_reader :password
  after_initialize :ensure_session_token

  validates :email, :session_token, :password_digest, presence: true
  validates :password, :length {minimum: 8, allow_nill: true}

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @pasword = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def find_by_credentials(username, password)
    found_user = User.find_by(username: username)
    return nil unless found_user
    if found_user.is_password?(password)
      found_user
    else
      nil
    end
  end

end
