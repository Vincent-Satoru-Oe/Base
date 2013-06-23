class User < ActiveRecord::Base
  	attr_accessible(:name, :email, :password, :password_confirmation)

  	validates :name, :presence => true, :uniqueness => true, :length => {maximum: 50}
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, :uniqueness => {case_sensitive: false}
  	validates :password, :presence => true, length: {:minimum => 6}
  	validates :password_confirmation, :presence => true
  	before_save { |user| user.email = email.downcase }

  	has_secure_password
end
