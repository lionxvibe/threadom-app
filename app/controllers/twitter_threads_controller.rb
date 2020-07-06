class TwitterThreadsController < ApplicationController
  before_action :auth
  before_action :set_twitter_thread, only: [:show, :edit, :update, :destroy]
  before_action :is_not_posted, only: [:edit, :update]

  # GET /twitter_threads
  # GET /twitter_threads.json
  def index
    @twitter_threads = TwitterThread.where(user: current_user)
  end

  # GET /twitter_threads/1
  # GET /twitter_threads/1.json
  def show
  end

  # GET /twitter_threads/new
  def new
    @twitter_thread = TwitterThread.new
  end

  # GET /twitter_threads/1/edit
  def edit
  end

  # POST /twitter_threads
  # POST /twitter_threads.json
  def create
    @twitter_thread = TwitterThread.new(twitter_thread_params)
    @twitter_thread.user = current_user

    respond_to do |format|
      if @twitter_thread.save
        format.html { redirect_to twitter_thread_url(@twitter_thread) }
        format.json { render :show, status: :created, location: @twitter_thread }
      else
        format.html { render :new }
        format.json { render json: @twitter_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitter_threads/1
  # PATCH/PUT /twitter_threads/1.json
  def update
    respond_to do |format|
      if @twitter_thread.update(twitter_thread_params)
        unless @twitter_thread.scheduled_at.nil?
          TweetThreadJob.set(wait_until: @twitter_thread.scheduled_at).perform_later(@twitter_thread)
        end
        format.html { redirect_to @twitter_thread, notice: 'Twitter thread was successfully updated.' }
        format.json { render :show, status: :ok, location: @twitter_thread }
      else
        format.html { render :edit }
        format.json { render json: @twitter_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter_threads/1
  # DELETE /twitter_threads/1.json
  def destroy
    @twitter_thread.destroy
    respond_to do |format|
      format.html { redirect_to twitter_threads_url }
      format.json { head :no_content }
    end
  end

  private

  def set_twitter_thread
    @twitter_thread = TwitterThread.find(params[:id])
  end

  def twitter_thread_params
    params.require(:twitter_thread).permit(:scheduled_at) if params[:twitter_thread]
  end

  def is_not_posted
    redirect_to twitter_threads_path unless @twitter_thread.posted_at.nil?
  end

end
