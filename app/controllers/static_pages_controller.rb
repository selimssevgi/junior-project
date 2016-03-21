class StaticPagesController < ApplicationController
  def home
    redirect_to movies_path if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
