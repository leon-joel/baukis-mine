class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      # ログイン済み
      redirect_to :staff_root
    else
      # ログインフォームを表示
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end

    if staff_member
      session[:staff_member_id] = staff_member.id
      redirect_to :staff_root
    else
      render action: 'new'
    end
  end

  # ログアウト
  def destroy
    # sessionオブジェクトから staff_member_id を削除し
    session.delete(:staff_member_id)
    # スタッフのトップページに
    redirect_to :staff_root
  end
end
