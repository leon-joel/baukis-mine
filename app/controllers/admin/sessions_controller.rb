class Admin::SessionsController < Admin::Base
  # ※親クラスで指定されている :authorize before_action はこのクラスでは不要なのでスキップする
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      if administrator.suspended?
        flash.now.alert = 'アカウントが停止されています。'
        render action: 'new'
      else
        session[:administrator_id] = administrator.id
        flash.notice = 'ログインしました。'
        redirect_to :admin_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :admin_root
  end
end
