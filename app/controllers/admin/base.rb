class Admin::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

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

  def check_account
    if current_administrator && current_administrator.suspended?
      # ログイン済み && 非active（＝無効）アカウント の場合 ⇒ 強制ログアウト
      session.delete(:administrator_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :admin_root
    end
  end

  # セッションタイムアウト時間 ※無操作時間がこれより長いと強制ログアウトする
  TIMEOUT = 60.minutes

  def check_timeout
    if current_administrator
      if TIMEOUT.ago <= session[:last_access_time]    # ※session[:last_access_time]がnilになることはないのだろうか??? ※nilの場合⇒ ArgumentError:comparison of ActiveSupport::TimeWithZone with nil failed
        # タイムアウトに達していない ⇒ 最終アクセス時刻を更新
        session[:last_access_time] = Time.current
      else
        # タイムアウトに達している ⇒ 強制ログアウト
        session.delete(:administrator_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :admin_login
      end
    end
  end

end
