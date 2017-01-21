class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # layoutを動的に切り替える仕組み
  layout :set_layout

  # controllerエラークラス
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  # 例外ハンドラーの登録 ※親子関係にある例外は【親】の方を先に（上に）書かないといけない。そうしないと全部親のハンドラーで処理されてしまう
  rescue_from Exception, with: :rescue500
  rescue_from Forbidden, with: :rescue403
  rescue_from IpAddressRejected, with: :rescue403

  private
  def set_layout
    # コントローラー名（staff/top など）にマッチしたlayoutを返す
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

  # 403: Forbidden
  def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end

  # 500: Internal Server Error
  def rescue500(e)
    @exception = e
    render "errors/internal_server_error", status: 500
  end
end
