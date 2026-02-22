class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, presence: true, length: { minimum: 1, maximum: 280 }
  # after_create_commit { broadcast_prepend_to "tweets" }
  # after_update_commit { broadcast_replace_to "tweets" }
  # after_destroy_commit { broadcast_remove_to "tweets" }
  # broadcasts_to ->(tweet) { "tweets" }, inserts_by: :prepend
  broadcasts_refreshes_to ->(tweet) { "tweets" }
end
