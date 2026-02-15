class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :destroy, :update, :show, :edit ]
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)

    # 1. The Switchboard: Checks if the browser wants HTML or a Turbo Stream
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: "Tweet was created successfully" }
      else
        @tweets = Tweet.all.order(created_at: :desc)

        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("tweet_form",
                partial: "tweets/form",
                locals: { tweet: @tweet })
        }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
        # This is for browsers with JS disabled or if you want a full reload
        format.html { redirect_to tweets_path, notice: "Tweet deleted" }

        # This tells the browser: "The model already sent the removal instruction,
        # so just finish the request silently without a full page reload."
        format.turbo_stream
    end
  end


  def edit
  end
  def show
  end

  def update
    if @tweet.update(tweet_params)
      # This redirect is caught by the Turbo Frame!
      redirect_to @tweet, notice: "Tweet updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end

  def set_tweet
        @tweet = Tweet.find(params[:id])
  end
end
