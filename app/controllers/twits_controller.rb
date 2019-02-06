class TwitsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @twit=current_user.twits.build(twit_params)
    if @twit.save
      flash[:success]='メッセージを投稿しました。'
      redirect_to root_url
    else
      @twits=current_user.feed_twits.order('created_at DESC').page(params[:page])
      flash.now[:danger]='メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @twit.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def twit_params
    params.require(:twit).permit(:content)
  end

  def correct_user
    @twit = current_user.twits.find_by(id: params[:id])
    unless @twit
      redirect_to root_url
    end
  end
end
