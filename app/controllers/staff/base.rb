class Staff::Base < ApplicationController
  before_action :authorize

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


end
