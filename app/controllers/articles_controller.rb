class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new 
  end

  def edit 
    @article = Article.find(params[:id])
  end

  def create
    #render plain: params[:article]  
    @article = Article.new(params.require(:article).permit(:title,:description,:author))
    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to @article
    
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title,:description,:author))
      flash[:notice] = "Article was Updated successfully."
      redirect_to @article
    else
      render 'edit'
    end

  end

end