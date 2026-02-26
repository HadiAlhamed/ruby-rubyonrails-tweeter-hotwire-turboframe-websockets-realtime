class Comments::CommentsController < ApplicationController
  include Commentable

  before_action :set_commentable

  private
  def set_commentable
    @parent = Comment.find(params[:comment_id])# parent comment of this comment(reply)
    @commentable = @parent.commentable # the tweet of all comments and replies
  end
end
