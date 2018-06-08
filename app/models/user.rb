# frozen_string_literal: true

class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true, lenght: {maximum: Settings.name_max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, lenght: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.password_min_length}
end
