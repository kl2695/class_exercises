class User < ApplicationRecord

  validates :email_address, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pass_hash = BCrypt::Password.new(self.password_digest)
    pass_hash.is_password?(password)
  end



  def self.find_by_credentials(email_address, password)
    user = User.find_by(email_address: email_address)
    return nil if user.nil?

    if user.is_password?(password)
      return user
    else
      return nil
    end

  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end




end
