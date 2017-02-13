class Admin::Base < ApplicationController
  before_action :authorize

  private
  # 現在ログインしているAdminを返す
  # ※1回のリクエストごとにキャッシュされるので複数回呼び出してもDB検索は1回しか走らない
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
          Administrator.find_by_id(session[:administrator_id])
    end
  end

  # Viewでも使用できるように
  helper_method :current_administrator

  def authorize
    unless current_administrator
      # 「adminとしてログイン」していなかったら
      redirect_to :admin_login   # ログイン画面にredirect

      # ★before_action内で render, redirect_to したら、アクション本体（後続のactionも？）は実行されない
      #   もしくは、[Rails4の場合]return false しても同様にアクション本体（後続のactionも？）は実行されない。
      #   ※[Rails5の場合] throw(:abort) する。
    end
  end
end
