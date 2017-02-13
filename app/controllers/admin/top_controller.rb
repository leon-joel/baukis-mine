class Admin::TopController < Admin::Base
  # ※親クラスで指定されている :authorize before_action はこのクラスでは不要なのでスキップする
  skip_before_action :authorize

  def index
    if current_administrator
      render action: 'dashboard'
    else
      render action: 'index'
    end
  end
end
