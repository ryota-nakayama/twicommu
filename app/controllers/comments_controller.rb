class CommentsController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comment
    @comment = Comment.new
  end
  
  def create
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comment.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to tweet
    else
      flash[:danger] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end  
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end  
end
