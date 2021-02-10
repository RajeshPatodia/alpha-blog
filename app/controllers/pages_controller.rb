class PagesController < ApplicationController
  def home
    redirect_to articles_path if loggedIn?
  end
  def about
  end
end
