class User < ActiveRecord::Base
  # Remember to create a migration!
  has_secure_password

  has_many :entries

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :name, presence: true
  validates :password_digest, presence: true

end
