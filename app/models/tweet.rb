class Tweet < ApplicationRecord
  validates :body, presence: true, length: { minimum: 1, maximum: 280 }
  after_create_commit { broadcast_prepend_to "tweets" }
end
