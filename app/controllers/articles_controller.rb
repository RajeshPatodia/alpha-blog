class ArticlesController < ApplicationController

  before_action :set_article, only:[:show,:edit,:update,:destroy] 
  before_action :require_user, except:[:show, :index]
  before_action :require_same_user, only:[:edit, :update, :destroy]
  
  def show
    #@article = Article.find(params[:id])
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new 
  end

  def edit 
    #@article = Article.find(params[:id])
  end

  def create
    #render plain: params[:article] 
    @article = Article.new(whitelist)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to @article
    
    else
      render 'new'
    end
  end

  def update
    #@article = Article.find(params[:id])
    if @article.update(whitelist)
      flash[:notice] = "Article was Updated successfully."
      redirect_to @article
    else
      render 'edit'
    end

  end

  def destroy
   # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private 
  def set_article
    @article = Article.find(params[:id])
  end

  def require_user
    if !loggedIn?
      flash[:alert] = "You must be logged in first to perform this action."
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article."
      redirect_to @article
    end
  end
  
  def whitelist
    params.require(:article).permit(:title,:description,:author)
  end

end