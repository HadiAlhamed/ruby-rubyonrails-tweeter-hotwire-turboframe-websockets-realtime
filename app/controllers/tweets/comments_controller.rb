class Tweets::CommentsController < ApplicationController
  include Commentable
  before_action :set_commentable

  private
  def set_commentable
    @commentable = Tweet.find(params[:id])
  end
end
