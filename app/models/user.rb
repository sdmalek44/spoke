class User < ApplicationRecord
  validates_presence_of :password, :username, :email
  validates_uniqueness_of :username
  has_secure_password
end
