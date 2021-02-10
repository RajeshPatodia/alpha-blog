class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :delete]
  before_action :require_user, only: [:edit, :update, :delete]
  before_action :require_same_user, only: [:edit, :update, :delete]
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

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Your profile and all your articles were deleted successfully"
    redirect_to articles_path
  end

  private

  def whitelist
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_user
    if !loggedIn?
      flash[:alert] = "You must be logged in first to perform this action."
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only edit your own profile."
      redirect_to user_path
    end
  end
end