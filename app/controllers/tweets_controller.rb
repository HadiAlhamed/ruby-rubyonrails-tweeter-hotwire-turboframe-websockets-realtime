class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_tweet, only: [ :destroy, :update, :edit ]
  before_action :correct_user, only: [ :destroy, :update, :edit ]
  before_action :set_current_user_id # only: [ :edit, :show, :index, :create, :update ]
  def index
    @tweet = Tweet.new
    @tweets = Tweet.includes(:user).all.order(created_at: :desc)
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      respond_to do |format|
        format.turbo_stream # Rails will automatically use create.turbo_stream.erb
        format.html { redirect_to tweets_path, notice: "Tweet created!" }
      end
    else
    # Re-fetch tweets so the index view has them if needed
    @tweets = Tweet.includes(:user).all.order(created_at: :desc)

      respond_to do |format|
        # This tells Turbo: "Forget the stream for a second,
        # just render the HTML partial/page and I'll handle it"
        format.html { render :index, status: :unprocessable_entity }

        # OR, the better Turbo way:
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("tweet_form",
                partial: "tweets/form",
                 locals: { tweet: @tweet, current_user_id: current_user&.id })
        }
      end
    end
  end


  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.turbo_stream # Rails will use update.turbo_stream.erb
        format.html { redirect_to tweets_path, notice: "Tweet updated!" }
      else
        # When update fails, replace the specific tweet's edit form
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(dom_id(@tweet),
                 partial: "tweets/form",
                 locals: { tweet: @tweet, current_user_id: current_user&.id })
        }
        format.html { render :edit, status: :unprocessable_entity }

      end
    end
  end


  def destroy
    @tweet.destroy

    respond_to do |format|
      format.turbo_stream # Rails will use destroy.turbo_stream.erb
      format.html { redirect_to tweets_path, notice: "Tweet deleted" }
    end
  end



  def edit
    @tweet = Tweet.find(params[:id])
  end
  def show
    @tweet = Tweet.find(params[:id])
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

  def set_current_user_id
    @current_user_id = current_user&.id
  end
end
