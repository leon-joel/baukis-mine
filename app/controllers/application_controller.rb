class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # layoutを動的に切り替える仕組み
  layout :set_layout

  # controllerエラークラス
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  # [productionのみ]ユーザーフレンドリーなエラー画面を表示する
  include ErrorHandlers if Rails.env.production?

  private
  def set_layout
    # コントローラー名（staff/top など）にマッチしたlayoutを返す
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

end
