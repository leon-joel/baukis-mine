module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    # 例外ハンドラーの登録 ※親子関係にある例外は【親】の方を先に（上に）書かないといけない。そうしないと全部親のハンドラーで処理されてしまう
    rescue_from Exception, with: :rescue500
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private
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