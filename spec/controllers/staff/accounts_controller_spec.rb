# require 'rspec'         # for non-Rails
require 'rails_helper'  # for Rails

describe Staff::AccountsController, 'ログイン前' do
  it_behaves_like 'a protected singular staff controller'
end

describe Staff::AccountsController do
  describe "#update" do
    # attributes_for: FactoryGirlsのメソッド。引数のfactoryを元にhashを生成してくれる
    let(:params_hash) { attributes_for(:staff_member)}
    let(:staff_member) { create(:staff_member)}

    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = 1.second.ago
    end

    example 'email属性を変更する' do
      params_hash.merge!(email: 'test@example.com')
      patch :update, id: staff_member.id, staff_member: params_hash
      staff_member.reload
      expect(staff_member.email).to eq('test@example.com')
    end

    example '例外ActionController::ParameterMissingが発生' do
      bypass_rescue
      expect { patch :update, id: staff_member.id }
          .to raise_error(ActionController::ParameterMissing)
    end

    example 'end_dateの値は書き換え不可' do
      params_hash.merge!(end_date: Date.tomorrow)
      expect {
        patch :update, id: staff_member.id, staff_member: params_hash
      }.not_to change {staff_member.end_date}
    end
  end
end
