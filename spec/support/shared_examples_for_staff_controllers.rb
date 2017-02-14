shared_examples 'a protected staff controller' do

  describe "#index" do
    example 'ログインフォームにリダイレクト' do
      # ログインしていないのでログインフォームにリダイレクトされること
      # （つまりbefore_action :authorize が効いていること）を確認する
      get :index
      expect(response).to redirect_to staff_login_url
    end
  end

  describe "#show" do
    example 'ログインフォームにリダイレクト' do
      # before_actionでリダイレクトされるので id は使用されることはないが、
      # 何か指定しておかないと ActionController::UrlGenerationError が発生する
      get :show, id: 1
      expect(response).to redirect_to staff_login_url
    end
  end
end

# こちらは単数リソース用の共有example
shared_examples 'a protected singular staff controller' do
  describe "#show" do
    example 'ログインフォームにリダイレクト' do
      get :show
      expect(response).to redirect_to staff_login_url
    end
  end
end