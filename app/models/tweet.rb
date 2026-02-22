class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, presence: true, length: { minimum: 1, maximum: 280 }
  broadcasts_to ->(tweet) { "tweets" }, inserts_by: :prepend
end
