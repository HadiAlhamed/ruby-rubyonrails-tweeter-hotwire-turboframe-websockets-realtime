class RetweetsController < ApplicationController
  before_action :set_tweet
  before_action :authenticate_user!

  def create
    @tweet.increment! :retweets
    redirect_to @tweet
  end

  private
  def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
  end
end
