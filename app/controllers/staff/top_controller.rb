class Staff::TopController < Staff::Base
  # ※親クラスで指定されている :authorize before_action はこのクラスでは不要なのでスキップする
  skip_before_action :authorize

  def index
    render action: 'index'
  end
end
