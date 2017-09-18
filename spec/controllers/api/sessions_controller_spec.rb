RSpec.describe Api::SessionsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:params) { { session: { email: 'bob@bob.com', password: '1111' } } }

    let(:session) { double }

    before { expect(Session).to receive(:new).with(permit!(email: 'bob@bob.com', password: '1111')).and_return(session) }

    before { expect(session).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end


  describe '#destroy' do
    let(:user) { stub_model User }

    before { sign_in user }

    let(:session) { double }

    before { expect(Session).to receive(:new).with(user: user).and_return(session) }

    before { expect(session).to receive(:destroy!) }

    before { process :destroy, method: :delete, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
