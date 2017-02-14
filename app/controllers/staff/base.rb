class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  private
  # 現在ログインしているStaffMemberを返す
  # ※1回のリクエストごとにキャッシュされるので複数回呼び出してもDB検索は1回しか走らない
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||=
          StaffMember.find_by_id(session[:staff_member_id])
    end
  end

  # Viewでも使用できるように
  helper_method :current_staff_member

  def authorize
    unless current_staff_member
      # 「staffとしてログイン」していなかったら
      flash.alert = '職員としてログインして下さい。' # flashメッセージを出して
      redirect_to :staff_login   # ログイン画面にredirect

      # ★before_action内で render, redirect_to したら、アクション本体（後続のactionも？）は実行されない
      #   もしくは、[Rails4の場合]return false しても同様にアクション本体（後続のactionも？）は実行されない。
      #   ※[Rails5の場合] throw(:abort) する。
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      # ログイン済み && 非active（＝無効）アカウント の場合 ⇒ 強制ログアウト
      session.delete(:staff_member_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :staff_root
    end
  end

  # セッションタイムアウト時間 ※無操作時間がこれより長いと強制ログアウトする
  TIMEOUT = 60.minutes

  def check_timeout
    if current_staff_member
      if TIMEOUT.ago <= session[:last_access_time]    # ※session[:last_access_time]がnilになることはないのだろうか??? ※nilの場合⇒ ArgumentError:comparison of ActiveSupport::TimeWithZone with nil failed
        # タイムアウトに達していない ⇒ 最終アクセス時刻を更新
        session[:last_access_time] = Time.current
      else
        # タイムアウトに達している ⇒ 強制ログアウト
        session.delete(:staff_member_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :staff_login
      end
    end
  end

end
