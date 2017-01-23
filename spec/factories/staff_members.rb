FactoryGirl.define do
  factory :staff_member do
    # 0始まりの連番
    sequence(:email) { |n| "member#{n}@example.com" }

    # ※以下は属性と同じ名前のメソッドを呼び出している
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'pw'
    start_date { Date.yesterday }
    end_date nil
    suspended false
  end
end