# form_forの引数に指定できるFormオブジェクト
# ・ActiveRecord::Baseを継承していない
# ・ActiveModel::Modelをincludeしている
class Staff::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
end