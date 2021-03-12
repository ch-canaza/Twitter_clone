# frozen_string_literal: true

# user model validations and permissions
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweet, dependent: :destroy
  # return an array of follows for the given user instance
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  # return an array of users who follow the user instance
  has_many :followees, through: :followed_users
  # returns an array of follows a user gave to someone else
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  # returns an array of other users who the user has followed
  has_many :followers, through: :following_users

  VALID_USER_NAME_REGEX = /\A@[A-Za-z0-9]+\Z/

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true,
              uniqueness: { case_sensitive: false},
              length: { minimum: 3, maximum: 50 }
  validates :user_name, presence: true,
              uniqueness: { case_sensitive: false},
              length: { minimum: 3, maximum: 25 },
              format: { with: VALID_USER_NAME_REGEX }

  before_save { self.email = email.downcase }

  def to_param
    user_name
  end
end
