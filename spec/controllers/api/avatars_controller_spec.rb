require 'rails_helper'

RSpec.describe Api::AvatarsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:params) { { user: { avatar: 'avatar' } } }

    let(:user) { stub_model User }

    before { sign_in user }

    before { expect(user).to receive(:update!).with(permit!(avatar: 'avatar')) }

    before { process :create, method: :post, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end

  describe '#destroy' do
    let(:user) { stub_model User }

    before { sign_in user }

    before { expect(user).to receive(:avatar=).with(nil) }

    before { expect(user).to receive(:save) }

    before { process :destroy, method: :delete, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
