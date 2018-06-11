require 'bcrypt'

class Message < ApplicationRecord
  include BCrypt

  has_secure_token key_length: 20

  validates :token, presence: true, uniqueness: true
  validates :message_body, presence: true
  validates :password, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
