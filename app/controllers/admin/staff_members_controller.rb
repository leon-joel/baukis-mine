class Admin::StaffMembersController < Admin::Base
  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [ :edit, :admin, staff_member ]  # edit_admin_staff_member_path(id: staff_member.id) と書いた方が分かりやすいと思うが…
  end

  def new
    @staff_member = StaffMember.new
  end
end
