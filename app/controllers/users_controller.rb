class UsersController < ApplicationController
    # before_action :set_user, only: %i[ show edit update destroy ]
  
    # GET /profile
    def show
      # @user = User.find(params[:id])
      @user = current_user
      @tweets = Tweet.all
    end
  end
  