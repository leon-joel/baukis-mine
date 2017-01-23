StaffMember.create!(
    email: 'taro@example.com',
    family_name: '山田',
    given_name: '太郎',
    family_name_kana: 'ヤマダ',
    given_name_kana: 'タロウ',
    password: 'password',
    start_date: Date.today
)

StaffMember.create!(
    email: 'suspended@example.com',
    family_name: 'さすぺ',
    given_name: '次郎',
    family_name_kana: 'サスペ',
    given_name_kana: 'ジロウ',
    password: 'password',
    start_date: Date.today,
    suspended: true
)