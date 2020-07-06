class TweetsController < ApplicationController
  before_action :auth
  before_action :set_twitter_thread
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = @twitter_thread.tweets
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = @twitter_thread.tweets.build
    render partial: 'tweets/form_add', locals: {tweet: @tweet}
  end

  # GET /tweets/1/edit
  def edit
    render partial: 'tweets/form', locals: {tweet: @tweet}
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = @twitter_thread.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { render partial: 'tweets/full_tweet', locals: {tweet: @tweet}}
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render partial: 'tweets/error', locals: {tweet: @tweet}, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { render partial: 'tweets/tweet', locals: {tweet: @tweet} }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render partial: 'tweets/error', locals: {tweet: @tweet}, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to @twitter_thread }
      format.json { head :no_content }
    end
  end

  private
  def set_tweet
    @tweet = @twitter_thread.tweets.find(params[:id])
  end

  def set_twitter_thread
    @twitter_thread = TwitterThread.find(params[:twitter_thread_id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, :twitter_thread_id)
  end
end
