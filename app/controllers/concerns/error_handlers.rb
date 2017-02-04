module ErrorHandlers
  extend ActiveSupport::Concern

  # 基本的には Production環境で動かす場合にのみ、このErrorハンドラーを有効にする。(application_controller.rb内でinclude)
  # ∵development/test環境では生のエラーをブラウザに表示した方が都合がいいので。

  included do
    # 例外ハンドラーの登録 ※親子関係にある例外は【親】の方を先に（上に）書かないといけない。そうしないと全部親のハンドラーで処理されてしまう
    rescue_from Exception, with: :rescue500
    rescue_from ActionController::ParameterMissing, with: :rescue400
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private
  # 400: Bad Request
  def rescue400(e)
    @exception = e
    render "errors/bad_request", status: 400
  end

  # 403: Forbidden
  def rescue403(e)
    @exception = e
    render "errors/forbidden", status: 403
  end

  # 404: Not Found
  def rescue404(e)
    @exception = e
    render "errors/not_found", status: 404
  end

  # 500: Internal Server Error
  def rescue500(e)
    @exception = e
    render "errors/internal_server_error", status: 500
  end
end