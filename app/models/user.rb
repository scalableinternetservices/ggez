class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :industry, presence: true
  has_many :resumes

  has_secure_password
end