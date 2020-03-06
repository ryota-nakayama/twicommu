class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tweet = current_user.tweets.build
      @tweets = current_user.tweets.order(id: :desc).page(params[:page])
      @user = User.find_by(params[:user_id])
    end  
  end
end
