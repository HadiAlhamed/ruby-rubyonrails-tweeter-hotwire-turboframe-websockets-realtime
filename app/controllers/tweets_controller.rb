class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to new_tweet_path, notice: "Tweet was created successfully"
    else
      @tweets = Tweet.all.order(created_at: :desc)
      render :new, status: :unprocessable_entity
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
