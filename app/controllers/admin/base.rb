class Admin::Base < ApplicationController
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
end
