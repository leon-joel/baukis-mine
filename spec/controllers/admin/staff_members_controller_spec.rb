# require 'rspec'         # for non-Rails
require 'rails_helper'  # for Rails

describe Admin::StaffMembersController do
  # attributes_for: FactoryGirlsのメソッド。引数のfactoryを元にhashを生成してくれる
  let(:params_hash) { attributes_for(:staff_member)}

  example 'attribute_forの確認' do
    expect(params_hash).not_to be_nil
    expect(params_hash[:family_name]).to eq("山田")
  end

  describe "#create" do
    example '職員一覧ページにリダイレクト' do
      post :create, staff_member: params_hash

      # ここは *_path ではなく *_url を使ってURL全体を返さないとパスしない
      # expect(response).to redirect_to(admin_staff_members_path)   # ∵redirect_to に path を与えると、rspecが test.host というホスト名を用いてURLを作る。"http://test.host/admin/staff_members"
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example "例外ActionController::ParameterMissingが発生" do
      # rescue_fromによる例外処理を無効にする
      bypass_rescue

      expect { post :create }.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "#update" do
    # FactoryGirlのcreateで実際にDBにレコードを保存している
    let(:staff_member){ create(:staff_member)}

    example 'suspendedフラグをセットする' do
      # suspended だけ値を入れ替える
      params_hash.merge!(suspended: true)
      # updateリクエストを送信 ※staff_member: xxx は patchリクエストの内部データ(?)
      patch :update, id: staff_member.id, staff_member: params_hash
      # DBの値を取得
      staff_member.reload
      # be_suspendedは述語マッチャー ※suspended? メソッドが呼び出される
      expect(staff_member).to be_suspended
    end

    example 'hashed_passwordの値は書き換え不可' do
      # passwordを削除 ※hashed_passwordのテストには邪魔だから（passwordがあるとhashed_passwordが更新されてしまうから）かな？
      params_hash.delete(:password)
      # hashed_passwordをセットする
      params_hash.merge!(hashed_password: 'x')
      # updateリクエストを送信してもhashed_passwordが変わらないことを確認
      expect {
        patch :update, id: staff_member.id, staff_member: params_hash
        staff_member.reload  # テキストではreleadしていないが、reloadしないと正しいテストにならないような気がする
      }.not_to change { staff_member.hashed_password.to_s }
      # staff_member.hashed_passwordは BCrypt::Passwordクラスのインスタンスで、==メソッドが生パスワードと比較するように実装されているので、
      # to_sしないと、必ずfalseとなってしまう。
    end

  end

end
