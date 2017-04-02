class StaffEvent < ActiveRecord::Base
  self.inheritance_column = nil   # typeカラムから特別な意味（親クラスで定義されている?）を取り除く

  belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'   # TODO: foreign_keyを指定しないといけないのはなぜ???
  alias_attribute :occurred_at, :created_at

  DESCRIPTIONS = {
      logged_in: 'ログイン',
      logged_out: 'ログアウト',
      rejected: 'ログイン拒否'
  }

  def description
    DESCRIPTIONS[type.to_sym]
  end
end
