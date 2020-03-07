class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.favo(tweet)
    flash[:success] = "お気に入りしました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user.unfavo(tweet)
    flash[:success] = "お気に入りを解除しました。"
    redirect_back(fallback_location: root_path)
  end
end
