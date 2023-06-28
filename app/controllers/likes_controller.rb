class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]

  # GET /likes
  def index
    @likes = Like.all
  end

  # GET /likes/1
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @like = @tweet.likes.build(user_id: current_user.id)
    if @like.save
      if !@tweet.replied_to_id?
        redirect_to tweets_path(@tweet)
      else 
        redirect_to tweet_path(@tweet.replied_to_id)
      end
    end
  end

  # PATCH/PUT /likes/1
  def update
    if @like.update(like_params)
      redirect_to @like, notice: "Like was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @like.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:user_id, :tweet_id)
    end
end
