require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:params) { { user: { email: 'bob@bob.com', password: '1111' } } }

    let(:user) { stub_model User }

    before { expect(User).to receive(:new).with(permit!(email: 'bob@bob.com', password: '1111')).and_return(user) }

    before { expect(user).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#show' do
    let(:user) { stub_model User }

    before { sign_in user }

    before { process :show, method: :get, format: :json }

    it { should render_template :show }
  end

  describe '#update' do
    let(:params) { { user: { first_name: 'Bob', last_name: 'Marley' } } }

    let(:user) { stub_model User }

    before { sign_in user }

    before { expect(user).to receive(:update!).with(permit!(first_name: 'Bob', last_name: 'Marley')) }

    before { process :update, method: :patch, params: params, format: :json }

    it { should render_template :update }
  end

  describe '#destroy' do
    let(:user) { stub_model User }

    before { sign_in user }

    before { expect(user).to receive(:destroy!) }

    before { process :destroy, method: :delete, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
