class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user=current_user
      @twit=current_user.twits.build
      @twits=current_user.twits.order('created_at DESC').page(params[:page])
    end
  end
end
