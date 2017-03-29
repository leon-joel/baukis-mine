class CreateStaffEvents < ActiveRecord::Migration
  def change
    create_table :staff_events do |t|
      t.references :staff_member, null: false   # 職員レコードへの外部キー: integer型の staff_member_id カラムが生成される
      t.string     :type, null: false           # イベントタイプ
      t.datetime   :created_at, null: false     # 発生時刻
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [ :staff_member_id, :created_at ]

    # 外部キーをセット 参照元テーブル名 ⇒ 参照先テーブル名 ※foreigner Gem によって提供されるメソッド
    add_foreign_key :staff_events, :staff_members
  end
end
