class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to users_path
    end
  end
end
