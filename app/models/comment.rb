class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, optional: true, class_name: "Comment"
  has_rich_text :body
  validates :body, presence: true
  after_create_commit -> {
    broadcast_append_to [ commentable, :comments ], target: "#{dom_id(parent || commentable)}_comments", partial: "comments/comment_with_replies"
  }
  after_update_commit -> {
    broadcast_replace_to self
  }
  after_destroy_commit do
    broadcast_remove_to self
    broadcast_action_to self, action: :remove, target: "#{dom_id(self)}_with_comments"
    # broadcast_action_to channel_name , action: :action_name, target : some_dom_id
  end
end
