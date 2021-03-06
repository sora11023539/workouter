class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  # destroyアクションをadminユーザーのみに
  before_action :admin_user, only: :destroy
  # 検索機能
  before_action :set_q, only: [:index, :search]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # アカウント有効化メール送信
      @user.send_activation_email
      flash[:success] = "登録したメールアドレスにアカウント有効化のメールを送信しましたのでご確認ください"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # プロフィール更新
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィール更新しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  # 有効化された全ユーザー表示
  def index
    # where 条件に一致したものを配列で返す
    @user = User.where(activated: true)
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @likes_count = @user.likes.count
  end

  # ユーザー削除
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def search
    @user = @q.result
  end

  private

    def set_q
      # 検索ワード受け取る
      @q = User.ransack(params[:q])
    end

    def user_params
      params.require(:user).permit( :name,
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    :avatar,
                                    :address,
                                    :birthday,
                                    :gender,
                                    :height,
                                    :weight,
                                    :proud,
                                    :introduction,
                                    :usedgym
                                  )
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to (root_url) unless current_user?(@user)
    end

    # adminユーザーか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def search_params
      params.require(:q).permit!
    end

end
