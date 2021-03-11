# frozen_string_literal: true

# follow model: giving permissions to follow and being followed
class Follow < ApplicationRecord
  # the user following another user
  belongs_to :follower, class_name: 'User'
  # the user being followed
  belongs_to :followee, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }
end
