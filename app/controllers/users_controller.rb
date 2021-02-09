class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelist)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}, you have successfully signed up!."
      redirect_to articles_path
    
    else
      render 'new'
    end
  end
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end
  def edit
  end

  def update
    if @user.update(whitelist)
      flash[:notice] = "Profile was Updated successfully."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index 
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  private

  def whitelist
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end