# form_forの引数に指定できるFormオブジェクト
# ・ActiveRecord::Baseを継承していない
# ・ActiveModel::Modelをincludeしている
class Admin::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
end