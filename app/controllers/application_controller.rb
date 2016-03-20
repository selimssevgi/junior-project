class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Every controller has its own helper class
  # and functionality of that class is available to all of related views
  
  # Put things here to make them available to whole application
  include SessionsHelper

  private 

    # corfirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
