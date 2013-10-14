class User < ActiveRecord::Base
	validates(:name, {presence: true, length: {maximum: 49}})
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates(:email, {presence: true, format: {with: VALID_EMAIL_REGEX}})
	validates(:email, {presence: true, uniqueness: {case_sensitive: false}})




end
