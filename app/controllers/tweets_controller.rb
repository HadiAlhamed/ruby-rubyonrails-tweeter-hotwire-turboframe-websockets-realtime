class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet was created successfully"
    else
      @tweets = Tweet.all.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
