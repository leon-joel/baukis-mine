class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      # 指定されたStaffのEvent一覧
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occurred_at: :desc)
    else
      # 全StaffのEvent一覧
      @events = StaffEvent.order(occurred_at: :desc)
    end
  end
end
