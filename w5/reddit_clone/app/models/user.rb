class User < ApplicationRecord

  validates :username, :session_token, presence:true, uniqueness:true
  validates :password_digest, presence: true
  validates :password, length: {minimum:6, allow_nil: true}

  after_initialize :ensure_session_token

  has_many :subs,
   primary_key: :id,
   foreign_key: :creator_id,
   class_name: :Sub

   has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user.nil?
      return nil
    else
      return user if user.is_password?(password)
    end
    nil

  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pass_hash = BCrypt::Password.new(self.password_digest)
    pass_hash.is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(32)
    self.save
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(32)
  end
end
