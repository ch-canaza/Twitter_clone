# frozen_string_literal: true

# tweet model: validations and permissions
class Tweet < ApplicationRecord
  belongs_to :user

  validates :tweet, presence: true,
                    length: { maximum: 280 }
end
