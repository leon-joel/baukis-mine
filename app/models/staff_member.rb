class StaffMember < ActiveRecord::Base
  before_validation do
    self.email_for_index = email.downcase if email
  end

  # 生パスワード文字列をハッシュ関数に掛けて、hashed_password にセットする
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  # アカウントがActive（有効）？
  def active?
    !suspended && start_date <= Date.today && (end_date.nil? || Date.today < end_date)
  end


end
