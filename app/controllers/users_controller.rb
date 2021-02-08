class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelist)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}, you have successfully signed up!."
      redirect_to articles_path
    
    else
      render 'new'
    end
  end

  def whitelist
    params.require(:user).permit(:username, :email, :password)
  end
end