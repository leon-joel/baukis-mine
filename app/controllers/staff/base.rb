class Staff::Base < ApplicationController
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
end
