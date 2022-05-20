class ApplicationController < ActionController::Base
  # ヘルパーメソッドを全てのページで使えるようにApplicationcontrollerから読み込み
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end
end
