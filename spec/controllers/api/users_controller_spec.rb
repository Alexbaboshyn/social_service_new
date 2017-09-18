require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    before { sign_in }

    before { process :index, method: :get, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    before { sign_in }

    before { process :show, method: :get, params: {id: 1}, format: :json }

    it { should render_template :show }
  end

  describe '#collection' do
    before { expect(User).to receive(:all).and_return(:collection) }

    its(:collection) { should eq :collection }
  end

  describe '#resource' do
    before { expect(subject).to receive(:params).and_return({ id: 1 }) }

    before { expect(User).to receive(:find).with(1).and_return(:resource) }

    its(:resource) { should eq :resource }
  end
end
