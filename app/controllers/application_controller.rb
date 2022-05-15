class ApplicationController < ActionController::Base
  # actionが実行される前に、指定したprivateアクション実行
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  # ヘルパーメソッドを全てのページで使えるようにApplicationcontrollerから読み込み
  include SessionsHelper

  private
    # ログイン済みか確認
    def logged_in_user
      unless logged_in?
        redirect_to login_url
      end
    end
end
