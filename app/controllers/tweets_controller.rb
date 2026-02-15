class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_tweet, only: [ :destroy, :update, :show, :edit ]
  before_action :correct_user, only: [ :destroy, :update, :edit ]
  def index
    @tweet = Tweet.new
    @tweets = Tweet.includes(:user).all.order(created_at: :desc)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    # 1. The Switchboard: Checks if the browser wants HTML or a Turbo Stream
    respond_to do |format|
      if @tweet.save

        format.turbo_stream {
        render turbo_stream: [
          turbo_stream.prepend("tweets",
          partial: "tweets/tweet",
          locals: { tweet: @tweet, current_user: current_user }),
          turbo_stream.replace("tweet_form", partial: "tweets/form", locals: { tweet: Tweet.new })
        ]
      }
      format.html { redirect_to tweets_path, notice: "Tweet created!" }
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
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@tweet),
            partial: "tweets/tweet",
            locals: { tweet: @tweet, current_user: current_user })
        }
        format.html { redirect_to tweets_path, notice: "Tweet updated!" }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@tweet),
            partial: "tweets/form",
            locals: { tweet: @tweet })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end

  def set_tweet
        @tweet = current_user.tweets.find(params[:id])
  end
  def correct_user
    @tweet = current_user.tweets.find_by(id: params[:id])
    redirect_to tweets_path, alert: "Not yours!" if @tweet.nil?
  end
end
