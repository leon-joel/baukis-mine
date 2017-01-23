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
    # paramからformオブジェクトを復元
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      # ユーザー検索
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end

    # ユーザー認証
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      if staff_member.suspended?
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        # 認証OK
        session[:staff_member_id] = staff_member.id
        flash.notice = 'ログインしました。'
        redirect_to :staff_root
      end
    else
      # 認証失敗
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  # ログアウト
  def destroy
    # sessionオブジェクトから staff_member_id を削除し
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました。'
    # スタッフのトップページに
    redirect_to :staff_root
  end
end