class User < ActiveRecord::Base

  attr_reader :password
  after_initialize :ensure_session_token

  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: {minimum: 8, allow_nil: true}

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    found_user = User.find_by(email: email)
    return nil unless found_user
    if found_user.is_password?(password)
      found_user
    else
      nil
    end
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

  def logged_in?
    
  end

end
