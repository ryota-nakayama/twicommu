class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  
  def index
    @users = User.order(id: :asc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "登録に成功しました。"
      redirect_to @user
    else
      flash.now[:danger] = "登録に失敗しました。"
      render :new
    end  
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = "プロフィールを変更しました。"
        redirect_to @user
      else
        flash.now[:danger] = "プロフィールの変更に失敗しました。"
        render :edit
      end
    else
      redirect_to root_url
    end  
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :image)
  end  
end
