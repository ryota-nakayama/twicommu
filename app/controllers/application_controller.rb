class ApplicationController < ActionController::Base
  include UsersHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end  
  
  def counts(user)
    @count_tweets = user.tweets.count
  end  
end
